class AddReasonForCheckToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :reason_for_check, :string
  end
end
