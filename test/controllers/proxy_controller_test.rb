require "test_helper"

class ProxyControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get proxy_show_url
    assert_response :success
  end
end
