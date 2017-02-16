require 'test_helper'

class ScheduleControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get schedule_show_url
    assert_response :success
  end

end
