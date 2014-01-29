require 'test_helper'

class FilterSamplesControllerTest < ActionController::TestCase
  setup do
    @filter_sample = filter_samples(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:filter_samples)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create filter_sample" do
    assert_difference('FilterSample.count') do
      post :create, filter_sample: {  }
    end

    assert_redirected_to filter_sample_path(assigns(:filter_sample))
  end

  test "should show filter_sample" do
    get :show, id: @filter_sample
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @filter_sample
    assert_response :success
  end

  test "should update filter_sample" do
    put :update, id: @filter_sample, filter_sample: {  }
    assert_redirected_to filter_sample_path(assigns(:filter_sample))
  end

  test "should destroy filter_sample" do
    assert_difference('FilterSample.count', -1) do
      delete :destroy, id: @filter_sample
    end

    assert_redirected_to filter_samples_path
  end
end
