require 'test_helper'

class Web::DeliveryLoadsControllerTest < ActionController::TestCase
  setup do
    user = create :user, :dispatcher
    sign_in user

    @delivery_load = create :delivery_load
    @attrs = attributes_for :delivery_load
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
end
