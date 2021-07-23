require "test_helper"

class LimitIpPathsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @limit_ip_path = limit_ip_paths(:one)
  end

  test "should get index" do
    get limit_ip_paths_url
    assert_response :success
  end

  test "should get new" do
    get new_limit_ip_path_url
    assert_response :success
  end

  test "should create limit_ip_path" do
    assert_difference('LimitIpPath.count') do
      post limit_ip_paths_url, params: { limit_ip_path: { ip: @limit_ip_path.ip, max_requests_day: @limit_ip_path.max_requests_day, max_requests_hour: @limit_ip_path.max_requests_hour, path: @limit_ip_path.path } }
    end

    assert_redirected_to limit_ip_path_url(LimitIpPath.last)
  end

  test "should show limit_ip_path" do
    get limit_ip_path_url(@limit_ip_path)
    assert_response :success
  end

  test "should get edit" do
    get edit_limit_ip_path_url(@limit_ip_path)
    assert_response :success
  end

  test "should update limit_ip_path" do
    patch limit_ip_path_url(@limit_ip_path), params: { limit_ip_path: { ip: @limit_ip_path.ip, max_requests_day: @limit_ip_path.max_requests_day, max_requests_hour: @limit_ip_path.max_requests_hour, path: @limit_ip_path.path } }
    assert_redirected_to limit_ip_path_url(@limit_ip_path)
  end

  test "should destroy limit_ip_path" do
    assert_difference('LimitIpPath.count', -1) do
      delete limit_ip_path_url(@limit_ip_path)
    end

    assert_redirected_to limit_ip_paths_url
  end
end
