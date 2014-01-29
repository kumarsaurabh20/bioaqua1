require 'test_helper'

class GeologiesControllerTest < ActionController::TestCase
  setup do
    @geology = geologies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:geologies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create geology" do
    assert_difference('Geology.count') do
      post :create, geology: {  }
    end

    assert_redirected_to geology_path(assigns(:geology))
  end

  test "should show geology" do
    get :show, id: @geology
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @geology
    assert_response :success
  end

  test "should update geology" do
    put :update, id: @geology, geology: {  }
    assert_redirected_to geology_path(assigns(:geology))
  end

  test "should destroy geology" do
    assert_difference('Geology.count', -1) do
      delete :destroy, id: @geology
    end

    assert_redirected_to geologies_path
  end
end
