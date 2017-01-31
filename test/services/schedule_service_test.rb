require 'test_helper'

class ScheduleServiceTest < ActionController::TestCase
  setup do
    @file = generate :file
  end

  test 'import' do
    number_for_overdue_order = '500402210'
    number_for_incorrect_order = '500393641'
    number_for_correct_order = '500396805'

    ScheduleService.expects(:get_date).with('9/15/2014').returns(Date.yesterday)
    ScheduleService.expects(:get_date).with('9/17/2014').returns(Date.today)
    ScheduleService.expects(:get_date).with('9/19/2014').returns(Date.tomorrow)

    ScheduleService.import(@file)

    assert { Order.count == 3 }
    assert { Order.find_by(purchase_order_number: number_for_overdue_order).need_checking? }
    assert { Order.find_by(purchase_order_number: number_for_incorrect_order).need_checking? }
    assert { Order.find_by(purchase_order_number: number_for_correct_order).unassigned? }
  end
end
