require 'test_helper'

class Web::DeliveryLoadsControllerTest < ActionController::TestCase
  setup do
    user = create :user, :dispatcher
    sign_in user

    @delivery_load = create :delivery_load, :morning, :with_driver
    @attrs = attributes_for :delivery_load, :afternoon
  end

  test 'index' do
    get :index
    assert_response :success
  end

  test 'new' do
    get :new
    assert_response :success
  end

  test 'edit' do
    get :edit, params: { id: @delivery_load }
    assert_response :success
  end

  test 'update' do
    put :update, params: { id: @delivery_load, delivery_load: @attrs }
    assert_response :redirect
  end

  test 'download' do
    sign_in @delivery_load.driver

    get :download, params: { id: @delivery_load }, format: :csv
    assert_response :success
  end
end
