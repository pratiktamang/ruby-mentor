require "test_helper"

class MentorTest < ActiveSupport::TestCase
  def setup
    @mentor = FactoryBot.build(:mentor)
  end

  test "should be valid" do
    assert @mentor.valid?
  end

  test "first_name should be present" do
    @mentor.first_name = ""
    assert_not @mentor.valid?
  end

  test "last_name should be present" do
    @mentor.last_name = ""
    assert_not @mentor.valid?
  end

  test "email should be present" do
    @mentor.email = ""
    assert_not @mentor.valid?
  end

  test "email should be unique" do
    duplicate_mentor = @mentor.dup
    duplicate_mentor.email = @mentor.email.upcase
    @mentor.save
    assert_not duplicate_mentor.valid?
  end

  test "password should be present" do
    @mentor.password = @mentor.password_confirmation = " " * 6
    assert_not @mentor.valid?
  end

  test "password should have a minimum length" do
    @mentor.password = @mentor.password_confirmation = "a" * 5
    assert_not @mentor.valid?
  end

  test "onboarded trait should set onboarded to true" do
    onboarded_mentor = FactoryBot.build(:mentor, :onboarded)
    assert onboarded_mentor.onboarded
  end
end
