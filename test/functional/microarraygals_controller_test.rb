require 'test_helper'

class MicroarraygalsControllerTest < ActionController::TestCase
  setup do
    @microarraygal = microarraygals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:microarraygals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create microarraygal" do
    assert_difference('Microarraygal.count') do
      post :create, microarraygal: {  }
    end

    assert_redirected_to microarraygal_path(assigns(:microarraygal))
  end

  test "should show microarraygal" do
    get :show, id: @microarraygal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @microarraygal
    assert_response :success
  end

  test "should update microarraygal" do
    put :update, id: @microarraygal, microarraygal: {  }
    assert_redirected_to microarraygal_path(assigns(:microarraygal))
  end

  test "should destroy microarraygal" do
    assert_difference('Microarraygal.count', -1) do
      delete :destroy, id: @microarraygal
    end

    assert_redirected_to microarraygals_path
  end
end
