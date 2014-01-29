require 'test_helper'

class MicroarraygprsControllerTest < ActionController::TestCase
  setup do
    @microarraygpr = microarraygprs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:microarraygprs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create microarraygpr" do
    assert_difference('Microarraygpr.count') do
      post :create, microarraygpr: {  }
    end

    assert_redirected_to microarraygpr_path(assigns(:microarraygpr))
  end

  test "should show microarraygpr" do
    get :show, id: @microarraygpr
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @microarraygpr
    assert_response :success
  end

  test "should update microarraygpr" do
    put :update, id: @microarraygpr, microarraygpr: {  }
    assert_redirected_to microarraygpr_path(assigns(:microarraygpr))
  end

  test "should destroy microarraygpr" do
    assert_difference('Microarraygpr.count', -1) do
      delete :destroy, id: @microarraygpr
    end

    assert_redirected_to microarraygprs_path
  end
end
