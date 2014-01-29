require 'test_helper'

class GalBlocksControllerTest < ActionController::TestCase
  setup do
    @gal_block = gal_blocks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gal_blocks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gal_block" do
    assert_difference('GalBlock.count') do
      post :create, gal_block: {  }
    end

    assert_redirected_to gal_block_path(assigns(:gal_block))
  end

  test "should show gal_block" do
    get :show, id: @gal_block
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gal_block
    assert_response :success
  end

  test "should update gal_block" do
    put :update, id: @gal_block, gal_block: {  }
    assert_redirected_to gal_block_path(assigns(:gal_block))
  end

  test "should destroy gal_block" do
    assert_difference('GalBlock.count', -1) do
      delete :destroy, id: @gal_block
    end

    assert_redirected_to gal_blocks_path
  end
end
