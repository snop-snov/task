require 'csv'

module ScheduleService
  DELIVERY_DATE_FORMAT = '%m/%d/%Y'.freeze

  class << self
    def import(file)
      CSV.parse(file.read, headers: true, header_converters: :symbol) do |row|
        process_order(row)
      end
    end

    private

    def process_order(data)
      order = Order.find_or_initialize_by(
        purchase_order_number: data[:purchase_order_number]
      )
      order.attributes = data.to_h.slice(
        :delivery_shift, :client_name, :destination_raw_line_1,
        :destination_city, :destination_zip, :phone_number,
        :purchase_order_number, :volume, :handling_unit_quantity
      )
      order.delivery_date = get_date(data[:delivery_date]) if data[:delivery_date].present?

      validate(order) if order.new_record?
      order.save! if order.changed?
    end

    def get_date(str)
      Date.strptime(str, DELIVERY_DATE_FORMAT)
    end

    def validate(order)
      validate_date(order)
      validate_address(order)
    end

    def validate_date(order)
      if order.delivery_date.blank? || order.delivery_date < Time.zone.today
        order.invalidate
      end
    end

    def validate_address(order)
      Settings.company_address.each do |key, value|
        order.invalidate if order.try(:"destination_#{key}") == value
      end
    end
  end
end
