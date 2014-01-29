require 'test_helper'

class CodeTypesControllerTest < ActionController::TestCase
  setup do
    @code_type = code_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:code_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create code_type" do
    assert_difference('CodeType.count') do
      post :create, code_type: {  }
    end

    assert_redirected_to code_type_path(assigns(:code_type))
  end

  test "should show code_type" do
    get :show, id: @code_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @code_type
    assert_response :success
  end

  test "should update code_type" do
    put :update, id: @code_type, code_type: {  }
    assert_redirected_to code_type_path(assigns(:code_type))
  end

  test "should destroy code_type" do
    assert_difference('CodeType.count', -1) do
      delete :destroy, id: @code_type
    end

    assert_redirected_to code_types_path
  end
end
