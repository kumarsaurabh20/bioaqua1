require 'test_helper'

class MeteorologicalDataControllerTest < ActionController::TestCase
  setup do
    @meteorological_datum = meteorological_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meteorological_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meteorological_datum" do
    assert_difference('MeteorologicalDatum.count') do
      post :create, meteorological_datum: {  }
    end

    assert_redirected_to meteorological_datum_path(assigns(:meteorological_datum))
  end

  test "should show meteorological_datum" do
    get :show, id: @meteorological_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meteorological_datum
    assert_response :success
  end

  test "should update meteorological_datum" do
    put :update, id: @meteorological_datum, meteorological_datum: {  }
    assert_redirected_to meteorological_datum_path(assigns(:meteorological_datum))
  end

  test "should destroy meteorological_datum" do
    assert_difference('MeteorologicalDatum.count', -1) do
      delete :destroy, id: @meteorological_datum
    end

    assert_redirected_to meteorological_data_path
  end
end
