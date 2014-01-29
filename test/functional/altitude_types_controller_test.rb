require 'test_helper'

class AltitudeTypesControllerTest < ActionController::TestCase
  setup do
    @altitude_type = altitude_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:altitude_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create altitude_type" do
    assert_difference('AltitudeType.count') do
      post :create, altitude_type: {  }
    end

    assert_redirected_to altitude_type_path(assigns(:altitude_type))
  end

  test "should show altitude_type" do
    get :show, id: @altitude_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @altitude_type
    assert_response :success
  end

  test "should update altitude_type" do
    put :update, id: @altitude_type, altitude_type: {  }
    assert_redirected_to altitude_type_path(assigns(:altitude_type))
  end

  test "should destroy altitude_type" do
    assert_difference('AltitudeType.count', -1) do
      delete :destroy, id: @altitude_type
    end

    assert_redirected_to altitude_types_path
  end
end
