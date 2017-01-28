require 'test_helper'

class Web::SchedulesControllerTest < ActionController::TestCase
  setup do
    user = create :user
    sign_in user
  end

  test 'new' do
    get :new
    assert_response :success
  end
end
