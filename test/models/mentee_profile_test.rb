require "test_helper"

class MenteeProfileTest < ActiveSupport::TestCase
  def setup
    @mentee = create(:mentee) # Assuming you have a mentee factory
    @mentee_profile = build(:mentee_profile,
      mentee: @mentee,
      country: "United States",
      city: "New York",
      workplace_url: "https://www.example.com",
      writing_ruby: true,
      start_source: "Online tutorials",
      underrepresented_group: true,
      mentoring_goals: "Improve my Ruby skills")
  end

  test "should be valid" do
    assert @mentee_profile.valid?
  end

  test "mentee_id should be present" do
    @mentee_profile.mentee = nil
    assert_not @mentee_profile.valid?
  end

  test "country should be present" do
    @mentee_profile.country = nil
    assert_not @mentee_profile.valid?
  end

  test "city should be present" do
    @mentee_profile.city = nil
    assert_not @mentee_profile.valid?
  end

  test "workplace_url should be present" do
    @mentee_profile.workplace_url = nil
    assert_not @mentee_profile.valid?
  end

  test "writing_ruby should be present" do
    @mentee_profile.writing_ruby = nil
    assert_not @mentee_profile.valid?
  end

  test "start_source should be present" do
    @mentee_profile.start_source = nil
    assert_not @mentee_profile.valid?
  end

  test "underrepresented_group should be present" do
    @mentee_profile.underrepresented_group = nil
    assert_not @mentee_profile.valid?
  end

  test "mentoring_goals should be present" do
    @mentee_profile.mentoring_goals = nil
    assert_not @mentee_profile.valid?
  end
end
