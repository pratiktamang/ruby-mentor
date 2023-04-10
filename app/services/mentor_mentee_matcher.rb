class MentorMenteeMatcher
  def initialize(mentors, mentees)
    @mentors = mentors.available
    @mentees = mentees.seeking_mentorship
  end

  def match
    mentee_mentor_pairs = []

    @mentees.each do |mentee|
      best_mentor = nil
      best_score = -1

      @mentors.each do |mentor|
        score = similarity_score(mentor, mentee)

        if score > best_score
          best_mentor = mentor
          best_score = score
        end
      end

      if best_mentor
        mentee_mentor_pairs << [mentee, best_mentor]
        mentee.update(seeking: false)
        best_mentor.update(available: false)
        @mentors = @mentors.reject { |mentor| mentor.id == best_mentor.id }
      end
    end

    mentee_mentor_pairs
  end

  def similarity_score(mentor, mentee)
    score = 0

    # Calculate location similarity
    if mentor.country.downcase == mentee.country.downcase
      score += 2
    end

    if mentor.city.downcase == mentee.city.downcase
      score += 1
    end

    # Calculate Ruby experience similarity
    experience_difference = (mentor.ruby_start_year.to_i - mentee.ruby_start_year.to_i).abs
    if experience_difference <= 5
      score += 1
    end

    score
  end
end
