require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get add" do
    get :add
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get plus" do
    get :plus
    assert_response :success
  end

  test "should get minus" do
    get :minus
    assert_response :success
  end

end
