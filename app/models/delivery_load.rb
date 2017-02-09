class DeliveryLoad < ApplicationRecord
  include Authority::Abilities

  belongs_to :driver, -> { drivers }, class_name: User
  has_many :orders

  scope :for_today, -> { where date: Date.today }

  validates :date, presence: true
  validates :delivery_shift, presence: true

  before_save :set_driver, if: -> { date == Date.today }

  # FIXME: use enumerize for delivery_shift
  def set_driver
    case delivery_shift
    when 'M', 'E'
      self.driver = User.drivers.find_by(shift: 1)
    when 'A'
      self.driver = User.drivers.find_by(shift: 2)
    end
  end

  def to_csv
    attributes = %w(date shift address client_name phone_number purchase_order_number)

    CSV.generate(headers: true) do |csv|
      csv << attributes

      orders.each do |order|
        values = []
        values << I18n.l(date, format: :date_only)
        values << delivery_shift
        values << order.address
        values << order.client_name
        values << order.phone_number
        values << order.purchase_order_number

        csv << values
      end
    end
  end

  def file_name
    ['Routing_list', I18n.l(date, format: :underscore), delivery_shift, 'csv'].join('.')
  end
end
