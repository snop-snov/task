FactoryGirl.define do
  factory :order do
    delivery_date { generate :date }
    client_name { generate :name }
    destination_raw_line_1 { generate :address }
    destination_city { generate :address }
    destination_zip { generate :integer }
    phone_number
    purchase_order_number { generate :string }
    volume { generate :float }
    handling_unit_quantity { generate :integer }
  end
end
