class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.datetime :delivery_date
      t.string :delivery_shift
      t.string :client_name
      t.string :destination_raw_line_1
      t.string :destination_city
      t.integer :destination_zip
      t.string :phone_number
      t.string :purchase_order_number
      t.float :volume
      t.integer :handling_unit_quantity
      t.string :state

      t.timestamps
    end
  end
end
