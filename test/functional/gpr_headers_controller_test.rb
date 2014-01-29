require 'test_helper'

class GprHeadersControllerTest < ActionController::TestCase
  setup do
    @gpr_header = gpr_headers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gpr_headers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gpr_header" do
    assert_difference('GprHeader.count') do
      post :create, gpr_header: {  }
    end

    assert_redirected_to gpr_header_path(assigns(:gpr_header))
  end

  test "should show gpr_header" do
    get :show, id: @gpr_header
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gpr_header
    assert_response :success
  end

  test "should update gpr_header" do
    put :update, id: @gpr_header, gpr_header: {  }
    assert_redirected_to gpr_header_path(assigns(:gpr_header))
  end

  test "should destroy gpr_header" do
    assert_difference('GprHeader.count', -1) do
      delete :destroy, id: @gpr_header
    end

    assert_redirected_to gpr_headers_path
  end
end
