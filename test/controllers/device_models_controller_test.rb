require 'test_helper'

class DeviceModelsControllerTest < ActionController::TestCase
  setup do
    @device_model = device_models(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:device_models)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create device_model" do
    assert_difference('DeviceModel.count') do
      post :create, device_model: { device_brand_id: @device_model.device_brand_id, device_type_id: @device_model.device_type_id, ethernet_interfaces: @device_model.ethernet_interfaces, rack_units: @device_model.rack_units, title: @device_model.title }
    end

    assert_redirected_to device_model_path(assigns(:device_model))
  end

  test "should show device_model" do
    get :show, id: @device_model
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @device_model
    assert_response :success
  end

  test "should update device_model" do
    patch :update, id: @device_model, device_model: { device_brand_id: @device_model.device_brand_id, device_type_id: @device_model.device_type_id, ethernet_interfaces: @device_model.ethernet_interfaces, rack_units: @device_model.rack_units, title: @device_model.title }
    assert_redirected_to device_model_path(assigns(:device_model))
  end

  test "should destroy device_model" do
    assert_difference('DeviceModel.count', -1) do
      delete :destroy, id: @device_model
    end

    assert_redirected_to device_models_path
  end
end
