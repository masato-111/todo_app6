require "test_helper"

class Tasks2ControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get tasks2_new_url
    assert_response :success
  end
end
