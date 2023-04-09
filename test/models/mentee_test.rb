require "test_helper"

class MenteeTest < ActiveSupport::TestCase
  def setup
    @mentee = FactoryBot.build(:mentee)
  end

  test "should be valid" do
    assert @mentee.valid?
  end

  test "first_name should be present" do
    @mentee.first_name = ""
    assert_not @mentee.valid?
  end

  test "last_name should be present" do
    @mentee.last_name = ""
    assert_not @mentee.valid?
  end

  test "email should be present" do
    @mentee.email = ""
    assert_not @mentee.valid?
  end

  test "email should be unique" do
    duplicate_mentee = @mentee.dup
    duplicate_mentee.email = @mentee.email.upcase
    @mentee.save
    assert_not duplicate_mentee.valid?
  end

  test "password should be present" do
    @mentee.password = @mentee.password_confirmation = " " * 6
    assert_not @mentee.valid?
  end

  test "password should have a minimum length" do
    @mentee.password = @mentee.password_confirmation = "a" * 5
    assert_not @mentee.valid?
  end

  test "onboarded trait should set onboarded to true" do
    onboarded_mentee = FactoryBot.build(:mentee, :onboarded)
    assert onboarded_mentee.onboarded
  end
end
