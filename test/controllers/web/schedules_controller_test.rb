require 'test_helper'

class Web::SchedulesControllerTest < ActionController::TestCase
  setup do
    user = create :user, :dispatcher
    sign_in user
  end

  test 'show' do
    user = create :user, :driver
    sign_in user

    get :show
    assert_response :success
  end

  test 'new' do
    get :new
    assert_response :success
  end

  test 'create' do
    file = generate :file
    ScheduleService.expects(:import).once

    post :create, params: { schedule: { file: file } }
    assert_response :redirect
  end
end
