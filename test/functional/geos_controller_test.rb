require 'test_helper'

class GeosControllerTest < ActionController::TestCase
  setup do
    @geo = geos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:geos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create geo" do
    assert_difference('Geo.count') do
      post :create, geo: {  }
    end

    assert_redirected_to geo_path(assigns(:geo))
  end

  test "should show geo" do
    get :show, id: @geo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @geo
    assert_response :success
  end

  test "should update geo" do
    put :update, id: @geo, geo: {  }
    assert_redirected_to geo_path(assigns(:geo))
  end

  test "should destroy geo" do
    assert_difference('Geo.count', -1) do
      delete :destroy, id: @geo
    end

    assert_redirected_to geos_path
  end
end
