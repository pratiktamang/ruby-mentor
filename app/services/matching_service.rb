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

    # Check if mentor's learning preferences match mentee's preferences
    mentor_learning_preferences = mentor_profile.learning_preferences.split(",").map(&:strip)
    mentee_learning_preferences = mentee_profile.learning_preferences.split(",").map(&:strip)
    learning_preferences_overlap = mentor_learning_preferences & mentee_learning_preferences
    learning_preferences_score = learning_preferences_overlap.length * 1

    # Check if mentor's and mentee's other languages match
    mentor_languages = mentor_profile.other_languages.split(",").map(&:strip)
    mentee_languages = mentee_profile.other_languages.split(",").map(&:strip)
    language_overlap = mentor_languages & mentee_languages
    language_match_score = language_overlap.length * 1

    # Calculate the total compatibility score
    total_score = (country_match ? 10 : 0) +
      (city_match ? 5 : 0) +
      availability_score +
      (industry_match ? 3 : 0) +
      specific_interests_score +
      learning_preferences_score +
      language_match_score

    match_details = {
      country_match: country_match,
      city_match: city_match,
      common_availability: common_availability,
      availability_score: availability_score,
      industry_match: industry_match,
      specific_interests_overlap: specific_interests_overlap,
      specific_interests_score: specific_interests_score,
      learning_preferences_overlap: learning_preferences_overlap,
      learning_preferences_score: learning_preferences_score,
      language_overlap: language_overlap,
      language_match_score: language_match_score,
      total_score: total_score
    }

    [total_score, match_details]
  end
end
