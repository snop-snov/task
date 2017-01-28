require 'test_helper'

class Web::SchedulesControllerTest < ActionDispatch::IntegrationTest
  test 'new' do
    get new_schedule_path
    assert_response :success
  end
end
