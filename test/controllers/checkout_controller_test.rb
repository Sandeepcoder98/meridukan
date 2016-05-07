require 'test_helper'

class CheckoutControllerTest < ActionController::TestCase
  test "should get get_started" do
    get :get_started
    assert_response :success
  end

  test "should get action_login" do
    get :action_login
    assert_response :success
  end

end
