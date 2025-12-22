require "test_helper"

class SurfSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get surf_sessions_index_url
    assert_response :success
  end

  test "should get new" do
    get surf_sessions_new_url
    assert_response :success
  end

  test "should get create" do
    get surf_sessions_create_url
    assert_response :success
  end
end
