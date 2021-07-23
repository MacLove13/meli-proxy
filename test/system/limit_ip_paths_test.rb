require "application_system_test_case"

class LimitIpPathsTest < ApplicationSystemTestCase
  setup do
    @limit_ip_path = limit_ip_paths(:one)
  end

  test "visiting the index" do
    visit limit_ip_paths_url
    assert_selector "h1", text: "Limit Ip Paths"
  end

  test "creating a Limit ip path" do
    visit limit_ip_paths_url
    click_on "New Limit Ip Path"

    fill_in "Ip", with: @limit_ip_path.ip
    fill_in "Max requests day", with: @limit_ip_path.max_requests_day
    fill_in "Max requests hour", with: @limit_ip_path.max_requests_hour
    fill_in "Path", with: @limit_ip_path.path
    click_on "Create Limit ip path"

    assert_text "Limit ip path was successfully created"
    click_on "Back"
  end

  test "updating a Limit ip path" do
    visit limit_ip_paths_url
    click_on "Edit", match: :first

    fill_in "Ip", with: @limit_ip_path.ip
    fill_in "Max requests day", with: @limit_ip_path.max_requests_day
    fill_in "Max requests hour", with: @limit_ip_path.max_requests_hour
    fill_in "Path", with: @limit_ip_path.path
    click_on "Update Limit ip path"

    assert_text "Limit ip path was successfully updated"
    click_on "Back"
  end

  test "destroying a Limit ip path" do
    visit limit_ip_paths_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Limit ip path was successfully destroyed"
  end
end
