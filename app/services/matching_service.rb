class PreferenceList
  attr_accessor :preferences

  def initialize(preferences = [])
    @preferences = preferences
  end

  def preferred
    @preferences.first
  end

  def remove(mentee)
    @preferences.delete(mentee)
  end

  def better_than(current_mentee, other_mentee)
    @preferences.index(other_mentee) < @preferences.index(current_mentee)
  end
end

class MatchingService
  def initialize(mentors, mentees)
    @mentors = mentors
    @mentees = mentees
  end

  def perform
    unmatched_mentees = @mentees.to_a.dup
    mentor_pref_lists = build_preference_lists(@mentors, @mentees)
    mentee_pref_lists = build_preference_lists(@mentees, @mentors)

    matched_pairs = {}
    iteration = 0

    while unmatched_mentees.any?
      iteration += 1
      puts "Iteration: #{iteration}"
      puts "Unmatched mentees: #{unmatched_mentees.map(&:id)}"

      mentee = unmatched_mentees.to_a.shift
      preferred_mentor = mentee_pref_lists[mentee].preferred

      if preferred_mentor.nil?
        puts "No more preferred mentors for mentee #{mentee.id}"
        next
      end

      if matched_pairs[preferred_mentor].nil?
        matched_pairs[preferred_mentor] = mentee
      else
        current_mentee = matched_pairs[preferred_mentor]
        if mentor_pref_lists[preferred_mentor]&.better_than(current_mentee, mentee)
          matched_pairs[preferred_mentor] = mentee
          unmatched_mentees << current_mentee
        else
          unmatched_mentees << mentee
        end
      end

      mentee_pref_lists[mentee].remove(preferred_mentor)
    end

    matched_pairs.each do |mentor, mentee|
      match_details = compatibility_score(mentor, mentee)
      Mentorship.create!(mentor: mentor, mentee: mentee, match_reasons: match_details.to_json)
    end
    puts "completed"
  end

  private

  def build_preference_lists(primary_group, secondary_group)
    preference_lists = {}

    primary_group.each do |primary|
      preferences = secondary_group.select do |secondary|
        primary_profile = primary.respond_to?(:mentor_profile) ? primary.mentor_profile : primary.mentee_profile
        secondary_profile = secondary.respond_to?(:mentor_profile) ? secondary.mentor_profile : secondary.mentee_profile
        primary_profile.country == secondary_profile.country
      end

      preferences = preferences.sort_by { |secondary| -compatibility_score(primary, secondary)[0] }
      preference_lists[primary] = PreferenceList.new(preferences)
    end

    preference_lists
  end

  def compatibility_score(mentor, mentee)
    puts "compatibility_score for mentor: #{mentor.id} and mentee: #{mentee.id}"
    return -1, {} unless mentor.respond_to?(:mentor_profile) && mentee.respond_to?(:mentee_profile)

    mentor_profile = mentor.mentor_profile
    mentee_profile = mentee.mentee_profile

    # location match
    country_match = mentor_profile.country == mentee_profile.country
    city_match = mentor_profile.city == mentee_profile.city

    # Calculate the availability score based on the common availability slots
    mentor_availability = mentor_profile.availability.map(&:strip)
    mentee_availability = mentee_profile.availability.map(&:strip)
    common_availability = mentor_availability & mentee_availability
    availability_score = (common_availability.length >= 1) ? common_availability.length : 0

    # Check if mentor's industry expertise matches mentee's desired industry
    industry_match = mentor_profile.industry_expertise == mentee_profile.desired_industry

    # Calculate the specific interests overlap score
    mentor_interests = mentor_profile.specific_interests.split(",").map(&:strip)
    mentee_interests = mentee_profile.specific_interests.split(",").map(&:strip)
    specific_interests_overlap = mentor_interests & mentee_interests
    specific_interests_score = specific_interests_overlap.length * 2

    # Calculate the total compatibility score
    total_score = (country_match ? 10 : 0) +
      (city_match ? 5 : 0) +
      availability_score +
      (industry_match ? 3 : 0) +
      specific_interests_score

    match_details = {
      country_match: country_match,
      city_match: city_match,
      common_availability: common_availability,
      availability_score: availability_score,
      industry_match: industry_match,
      specific_interests_overlap: specific_interests_overlap,
      specific_interests_score: specific_interests_score,
      total_score: total_score
    }

    # Return the total score as the first element of an array, followed by the match_details hash
    [total_score, match_details]
  end
end
# Limited mentors or mentees: If there are very few mentors or mentees available, it might be difficult to find suitable matches for everyone.
# In extreme cases, when there are no mentors or mentees, the code will not produce any matches.

# Mentors with multiple high compatibility scores: If a mentor has equally high compatibility scores with multiple mentees,
# the current implementation will match the mentor with the first encountered mentee in the list, potentially leaving other compatible
# mentees unmatched or with less suitable mentors.

# No mentors from the same country: The code requires that mentors and mentees be from the same country. If there are no mentors
# from the same country as a mentee, the code will return [nil, {}] for that mentee. This might not be desirable if there are mentors
# with similar interests and expertise from other countries who could still provide valuable mentorship.

# Equal weights for all factors: The code calculates the compatibility score using fixed weights for factors like city, availability,
# industry expertise, and specific interests. These weights might not accurately represent the importance of each factor for all users.
# For example, some mentees might prioritize industry expertise over being in the same city.

# Availability overlap not considered: The code calculates the availability score based on the number of overlapping available time slots
# between the mentor and mentee, but it does not consider the actual duration of the overlap. For instance, a 30-minute overlap might be
# considered the same as a 3-hour overlap, which may not accurately reflect the quality of the match.

# Inefficient algorithm: The current implementation of the code calculates the compatibility score between a mentor and mentee multiple times,
# which can be computationally expensive, especially when there are a large number of mentors and mentees. This can lead to performance issues.

# To address some of these edge cases and potential issues, you can consider:

# Allowing mentor-mentee matches across countries if no suitable mentors are available within the same country.
# Implementing a more sophisticated matching algorithm, such as the Gale-Shapley algorithm or other optimization techniques,
# to find stable and optimal matches.

# Allowing users to define their priorities and weights for each factor to better tailor the matching process to their needs.
# Considering the duration of the availability overlap when calculating the availability score.
# Optimizing the code to avoid redundant calculations of compatibility scores.

# Also, remember that the Gale-Shapley algorithm assumes an equal number of mentors and mentees and doesn't explicitly account for
# the same-country constraint. If these factors are important, you may need to adjust the algorithm to accommodate them.

# https://chat.openai.com/c/e4a9f886-cb43-4091-88cd-ff45bfa3c34d
