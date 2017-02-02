class DeliveryLoad < ApplicationRecord
  include Authority::Abilities

  belongs_to :driver, -> { drivers }, class_name: User
  has_many :orders

  scope :for_today, -> { where date: Date.today }

  validates :date, presence: true
  validates :delivery_shift, presence: true

  before_save :set_driver, if: -> { date == Date.today }
  after_save :assigne_orders

  # FIXME: use enumerize for delivery_shift
  def set_driver
    case delivery_shift
    when 'M', 'E'
      self.driver = User.drivers.find_by(shift: 1)
    when 'A'
      self.driver = User.drivers.find_by(shift: 2)
    end
  end

  def assigne_orders
    orders.each { |order| order.assigne! if order.may_assigne? }
  end
end
