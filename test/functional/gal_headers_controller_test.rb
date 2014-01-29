require 'test_helper'

class GalHeadersControllerTest < ActionController::TestCase
  setup do
    @gal_header = gal_headers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gal_headers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gal_header" do
    assert_difference('GalHeader.count') do
      post :create, gal_header: {  }
    end

    assert_redirected_to gal_header_path(assigns(:gal_header))
  end

  test "should show gal_header" do
    get :show, id: @gal_header
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gal_header
    assert_response :success
  end

  test "should update gal_header" do
    put :update, id: @gal_header, gal_header: {  }
    assert_redirected_to gal_header_path(assigns(:gal_header))
  end

  test "should destroy gal_header" do
    assert_difference('GalHeader.count', -1) do
      delete :destroy, id: @gal_header
    end

    assert_redirected_to gal_headers_path
  end
end
