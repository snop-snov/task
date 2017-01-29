class CreateDeliveryLoads < ActiveRecord::Migration[5.0]
  def change
    create_table :delivery_loads do |t|
      t.datetime :date
      t.string :delivery_shift

      t.timestamps
    end

    add_reference :delivery_loads, :driver, references: :users, index: true
    add_foreign_key :delivery_loads, :users, column: :driver_id
  end
end
