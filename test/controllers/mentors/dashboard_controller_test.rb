require "test_helper"

class Mentors::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mentors_dashboard_index_url
    assert_response :success
  end
end
