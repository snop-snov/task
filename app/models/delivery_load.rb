class DeliveryLoad < ApplicationRecord
  belongs_to :driver, -> { drivers }, class_name: User

  validate :check_role, if: :driver_id

  private

  def check_role
    User.drivers.find_by(id: driver_id).present?
  end
end
