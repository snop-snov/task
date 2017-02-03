FactoryGirl.define do
  factory :order do
    original_delivery_date { generate :date }
    delivery_date { generate :date }
    client_name { generate :name }
    destination_raw_line_1 { generate :address }
    destination_city { generate :address }
    destination_zip { generate :integer }
    phone_number
    purchase_order_number { generate :string }
    volume { generate :float }
    handling_unit_quantity { generate :integer }

    [:need_checking, :unassigned, :assigned, :performed].each do |state_name|
      trait state_name do
        state state_name
      end
    end
  end
end
