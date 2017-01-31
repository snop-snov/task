class DeliveryLoad < ApplicationRecord
  include Authority::Abilities

  belongs_to :driver, -> { drivers }, class_name: User
  has_many :orders

  scope :for_today, -> { where date: Date.today }

  validates :date, presence: true
  validates :delivery_shift, presence: true

  # TODO: set driver before save
end
