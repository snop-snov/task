class AddShiftToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :shift, :integer
  end
end
