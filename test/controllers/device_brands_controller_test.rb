require 'test_helper'

class DeviceBrandsControllerTest < ActionController::TestCase
  setup do
    @device_brand = device_brands(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:device_brands)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create device_brand" do
    assert_difference('DeviceBrand.count') do
      post :create, device_brand: { title: @device_brand.title }
    end

    assert_redirected_to device_brand_path(assigns(:device_brand))
  end

  test "should show device_brand" do
    get :show, id: @device_brand
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @device_brand
    assert_response :success
  end

  test "should update device_brand" do
    patch :update, id: @device_brand, device_brand: { title: @device_brand.title }
    assert_redirected_to device_brand_path(assigns(:device_brand))
  end

  test "should destroy device_brand" do
    assert_difference('DeviceBrand.count', -1) do
      delete :destroy, id: @device_brand
    end

    assert_redirected_to device_brands_path
  end
end
