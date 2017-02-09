module OrdersService
  class << self
    def assign_orders(delivery_load, order_ids)
      old_order_ids = delivery_load.orders.pluck(:id).map(&:to_s)
      new_order_ids = order_ids - old_order_ids || []
      removed_order_ids = old_order_ids - order_ids || []

      new_orders = Order.where(id: new_order_ids)
      new_orders.update(delivery_load_id: delivery_load.id, state: :assigned)

      removed_orders = Order.where(id: removed_order_ids)
      removed_orders.update(delivery_load_id: nil, state: :unassigned)
    end
  end
end
