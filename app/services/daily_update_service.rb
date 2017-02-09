module DailyUpdateService
  class << self
    def perform
      update_unassigned_orders
      update_assigned_orders
      switch_driver_shifts
      update_delivery_loads
    end

    private

    def update_unassigned_orders
      orders = Order.unassigned.overdue
      orders.update_all(delivery_date: Date.current)
    end

    def update_assigned_orders
      orders = Order.assigned
      orders.update_all(state: :performed)
    end

    def switch_driver_shifts
      first_shift_drivers = User.drivers.where(shift: 1).load
      second_shift_drivers = User.drivers.where(shift: 2).load

      first_shift_drivers.each { |d| d.update(shift: 2) }
      second_shift_drivers.each { |d| d.update(shift: 1) }
    end

    def update_delivery_loads
      delivery_loads = DeliveryLoad.for_today
      delivery_loads.each do |dl|
        dl.set_driver
        dl.save
      end
    end
  end
end
