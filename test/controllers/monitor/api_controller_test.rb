require "test_helper"

class Monitor::ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get monitor_api_index_url
    assert_response :success
  end
end
