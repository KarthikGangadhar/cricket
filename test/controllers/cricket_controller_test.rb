require 'test_helper'

class CricketControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get cricket_show_url
    assert_response :success
  end

end
