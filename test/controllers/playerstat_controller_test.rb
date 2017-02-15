require 'test_helper'

class PlayerstatControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get playerstat_show_url
    assert_response :success
  end

end
