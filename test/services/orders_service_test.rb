require 'test_helper'

class OrdersServiceTest < ActionController::TestCase
  setup do
    create_list :order, 3, :unassigned, delivery_shift: 'M'

    @orders = create_list :order, 3, :assigned, delivery_shift: 'M'
    @delivery_load = create :delivery_load, :morning, orders: @orders
  end

  test 'assign_orders' do
    new_orders = create_list :order, 5, :unassigned
    removed_order = @orders.first

    order_ids = new_orders.pluck(:id) + @orders.pluck(:id) - [removed_order.id]

    OrdersService.assign_orders(@delivery_load, order_ids.map(&:to_s))

    @delivery_load.reload

    assert { @delivery_load.orders.count == 7 }
    assert { removed_order.reload.unassigned? }
    assert { Order.unassigned.count == 4 }
    assert { Order.assigned.count == 7 }
  end
end
