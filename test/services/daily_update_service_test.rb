require 'test_helper'

class DailyUpdateServiceTest < ActionController::TestCase
  setup do
    @overdue_order = create :order, :unassigned, delivery_date: Date.yesterday
    @assigned_order = create :order, :assigned, delivery_date: Date.yesterday

    @first_shift_driver = create :user, :driver, shift: 1
    @second_shift_driver = create :user, :driver, shift: 2

    @delivery_load = create :delivery_load, :morning, date: Date.current
  end

  test 'perform' do
    DailyUpdateService.perform

    @overdue_order.reload
    @assigned_order.reload

    assert { @overdue_order.unassigned? }
    assert { @overdue_order.delivery_date == Date.current }
    assert { @assigned_order.performed? }
    assert { @assigned_order.delivery_date == Date.yesterday }

    @first_shift_driver.reload
    @second_shift_driver.reload

    assert { @first_shift_driver.shift == 2 }
    assert { @second_shift_driver.shift == 1 }

    @delivery_load.reload
    assert { @delivery_load.driver == @second_shift_driver }
  end
end
