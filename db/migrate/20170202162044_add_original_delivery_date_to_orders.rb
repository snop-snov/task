class AddOriginalDeliveryDateToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :original_delivery_date, :datetime
  end
end
