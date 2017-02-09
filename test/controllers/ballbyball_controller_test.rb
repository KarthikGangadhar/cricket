require 'test_helper'

class BallbyballControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get ballbyball_show_url
    assert_response :success
  end

end
