class User < ApplicationRecord
  include Authority::UserAbilities

  has_secure_password

  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :name, length: { maximum: 255 }
end
