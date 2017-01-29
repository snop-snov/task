class User < ApplicationRecord
  include Authority::UserAbilities

  has_many :delivery_loads

  scope :drivers, -> { where role: :driver }
  scope :dispatchers, -> { where role: :dispatcher }

  has_secure_password

  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :name, length: { maximum: 255 }
end
