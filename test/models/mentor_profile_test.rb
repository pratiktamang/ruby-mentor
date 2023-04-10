require "test_helper"

class MentorProfileTest < ActiveSupport::TestCase
  def setup
    @mentor = create(:mentor)
    @mentor_profile = build(:mentor_profile,
      mentor: @mentor,
      company_url: "https://www.example.com",
      ruby_start_year: 2015,
      country: "United States",
      city: "New York",
      previous_mentoring: true,
      motivation: "Help others")
  end

  test "should be valid" do
    assert @mentor_profile.valid?
  end

  test "mentor_id should be present" do
    @mentor_profile.mentor = nil
    assert_not @mentor_profile.valid?
  end

  test "company_url should be present" do
    @mentor_profile.company_url = nil
    assert_not @mentor_profile.valid?
  end

  test "ruby_start_year should be present" do
    @mentor_profile.ruby_start_year = nil
    assert_not @mentor_profile.valid?
  end

  test "country should be present" do
    @mentor_profile.country = nil
    assert_not @mentor_profile.valid?
  end

  test "city should be present" do
    @mentor_profile.city = nil
    assert_not @mentor_profile.valid?
  end

  test "previous_mentoring should be present" do
    @mentor_profile.previous_mentoring = nil
    assert_not @mentor_profile.valid?
  end

  test "motivation should be present" do
    @mentor_profile.motivation = nil
    assert_not @mentor_profile.valid?
  end
end
