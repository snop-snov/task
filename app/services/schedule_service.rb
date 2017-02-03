require 'csv'

module ScheduleService
  DELIVERY_DATE_FORMAT = '%m/%d/%Y'.freeze

  class << self
    def import(file)
      @orders = []

      CSV.parse(file.read, headers: true, header_converters: :symbol) do |row|
        process_order(row)
      end

      Order.import(@orders)
    end

    private

    def process_order(data)
      order_attrs = data.to_h.slice(
        :delivery_shift, :client_name, :destination_raw_line_1,
        :destination_city, :destination_zip, :phone_number,
        :purchase_order_number, :volume, :handling_unit_quantity
      )

      order = Order.new(order_attrs)
      order.original_delivery_date = get_date(data[:delivery_date]) if data[:delivery_date].present?
      order.set_delivery_date

      validate(order)
      @orders << order
    end

    def get_date(str)
      Date.strptime(str, DELIVERY_DATE_FORMAT)
    end

    def validate(order)
      validate_date(order)
      validate_address(order)
    end

    def validate_date(order)
      if order.original_delivery_date.blank?
        order.invalidate
        order.reason_for_check = I18n.t('reasons_for_check.blank_delivery_date')
      end
    end

    def validate_address(order)
      if company_address?(order)
        order.invalidate
        order.reason_for_check = I18n.t('reasons_for_check.wrong_address')
      end
    end

    def company_address?(order)
      origin_address = Settings.company_address

      order.client_name == origin_address.name &&
      order.destination_raw_line_1 == origin_address.raw_line_1 &&
      order.destination_city == origin_address.city &&
      order.destination_zip == origin_address.zip_code
    end
  end
end
