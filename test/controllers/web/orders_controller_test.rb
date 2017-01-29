require 'test_helper'

class Web::OrdersControllerTest < ActionController::TestCase
  setup do
    user = create :user, :dispatcher
    sign_in user

    @order = create :order
    @attrs = attributes_for :order
  end

  test 'index' do
    get :index
    assert_response :success
  end

  test 'edit' do
    get :edit, params: { id: @order }
    assert_response :success
  end

  test 'update' do
    put :update, params: { id: @order, order: @attrs }
    assert_response :redirect
  end
end
