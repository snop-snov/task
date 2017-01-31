require 'test_helper'

class Web::WelcomeControllerTest < ActionController::TestCase
  setup do
    user = create :user, :driver
    sign_in user
  end

  test 'index' do
    get :index
    assert_response :redirect
  end
end
