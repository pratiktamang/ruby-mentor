class MatchingService
  def initialize(mentors, mentees)
    @mentors = mentors
    @mentees = mentees
  end

  def perform
    matched_pairs = []

    @mentees.each do |mentee|
      best_mentor, match_details = find_best_mentor(mentee, @mentors)
      if best_mentor
        matched_pairs << {mentor: best_mentor, mentee: mentee, match_details: match_details}
        @mentors = @mentors.reject { |mentor| mentor.id == best_mentor.id }
      end
    end

    matched_pairs
  end

  private

  def find_best_mentor(mentee, mentors)
    best_mentor = nil
    best_score = -1
    best_match_details = {}

    mentors.each do |mentor|
      score, match_details = compatibility_score(mentor, mentee)
      if score > best_score
        best_score = score
        best_mentor = mentor
        best_match_details = match_details
      end
    end

    [best_mentor, best_match_details]
  end

  def compatibility_score(mentor, mentee)
    mentor_profile = mentor.profile
    mentee_profile = mentee.profile

    # Same country is a must
    return -1, {} if mentor_profile.country != mentee_profile.country

    # Calculate compatibility based on your criteria
    same_city_score = (mentor_profile.city == mentee_profile.city) ? 5 : 0
    common_availability = mentor_profile.availability & mentee_profile.availability
    availability_score = common_availability.length

    # Assign weights for other factors
    desired_industry_score = (mentor_profile.industry_expertise == mentee_profile.desired_industry) ? 3 : 0
    specific_interests_score = (mentor_profile.specific_interests.split(",") & mentee_profile.specific_interests.split(",")).count * 2

    total_score = same_city_score + availability_score + desired_industry_score + specific_interests_score

    match_details = {
      compatibility_score: total_score,
      same_city: mentor_profile.city == mentee_profile.city,
      common_availability: common_availability,
      desired_industry_match: mentor_profile.industry_expertise == mentee_profile.desired_industry,
      specific_interests_overlap: mentor_profile.specific_interests.split(",") & mentee_profile.specific_interests.split(",")
    }

    [total_score, match_details]
  end
end
