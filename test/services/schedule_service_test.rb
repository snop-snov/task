require 'test_helper'

class ScheduleServiceTest < ActionController::TestCase
  setup do
    @file = generate :file
  end

  test 'import' do
    number_for_overdue_order = '500402210'
    number_for_order_without_date = '500402240'
    number_for_incorrect_address_order = '500393641'
    number_for_correct_order = '500396805'

    ScheduleService.expects(:get_date).with('9/17/2014').returns(Date.yesterday)
    ScheduleService.expects(:get_date).with('9/18/2014').returns(Date.today)
    ScheduleService.expects(:get_date).with('9/19/2014').returns(Date.tomorrow)
    ScheduleService.expects(:get_date).with('9/20/2014').returns(Date.today + 2.days)

    ScheduleService.import(@file)

    assert { Order.count == 5 }

    overdue_order = Order.find_by(purchase_order_number: number_for_overdue_order, original_delivery_date: Date.yesterday)
    order_without_date = Order.find_by(purchase_order_number: number_for_order_without_date, original_delivery_date: nil)
    incorrect_address_order = Order.find_by(purchase_order_number: number_for_incorrect_address_order, original_delivery_date: Date.today)
    correct_order = Order.find_by(purchase_order_number: number_for_correct_order, original_delivery_date: Date.tomorrow)
    correct_order_double = Order.find_by(purchase_order_number: number_for_correct_order, original_delivery_date: Date.today + 2.days)

    assert { overdue_order.unassigned? }
    assert { order_without_date.need_checking? }
    assert { incorrect_address_order.need_checking? }
    assert { correct_order.unassigned? }
    assert { correct_order_double.unassigned? }

    assert { overdue_order.delivery_date == Date.today }
    assert { order_without_date.delivery_date == Date.today }
    assert { incorrect_address_order.delivery_date == Date.today }
    assert { correct_order.delivery_date == Date.tomorrow }
    assert { correct_order_double.delivery_date == Date.today + 2.days }
  end
end
