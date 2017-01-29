class AddDeliveryLoadIdToOrders < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :delivery_load, foreign_key: true
  end
end
