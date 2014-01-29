require 'test_helper'

class DataGprsControllerTest < ActionController::TestCase
  setup do
    @data_gpr = data_gprs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:data_gprs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create data_gpr" do
    assert_difference('DataGpr.count') do
      post :create, data_gpr: {  }
    end

    assert_redirected_to data_gpr_path(assigns(:data_gpr))
  end

  test "should show data_gpr" do
    get :show, id: @data_gpr
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @data_gpr
    assert_response :success
  end

  test "should update data_gpr" do
    put :update, id: @data_gpr, data_gpr: {  }
    assert_redirected_to data_gpr_path(assigns(:data_gpr))
  end

  test "should destroy data_gpr" do
    assert_difference('DataGpr.count', -1) do
      delete :destroy, id: @data_gpr
    end

    assert_redirected_to data_gprs_path
  end
end
