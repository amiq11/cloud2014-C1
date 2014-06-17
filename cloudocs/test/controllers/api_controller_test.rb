require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get payload" do
    get :payload
    assert_response :success
  end

  test "should get get_file" do
    get :get_file
    assert_response :success
  end

end
