require "application_system_test_case"

class MentorshipsTest < ApplicationSystemTestCase
  setup do
    @mentorship = mentorships(:one)
  end

  test "visiting the index" do
    visit mentorships_url
    assert_selector "h1", text: "Mentorships"
  end

  test "should create mentorship" do
    visit mentorships_url
    click_on "New mentorship"

    fill_in "Mentee", with: @mentorship.mentee_id
    fill_in "Mentor", with: @mentorship.mentor_id
    click_on "Create Mentorship"

    assert_text "Mentorship was successfully created"
    click_on "Back"
  end

  test "should update Mentorship" do
    visit mentorship_url(@mentorship)
    click_on "Edit this mentorship", match: :first

    fill_in "Mentee", with: @mentorship.mentee_id
    fill_in "Mentor", with: @mentorship.mentor_id
    click_on "Update Mentorship"

    assert_text "Mentorship was successfully updated"
    click_on "Back"
  end

  test "should destroy Mentorship" do
    visit mentorship_url(@mentorship)
    click_on "Destroy this mentorship", match: :first

    assert_text "Mentorship was successfully destroyed"
  end
end
