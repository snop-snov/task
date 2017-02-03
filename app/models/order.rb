class Order < ApplicationRecord
  include Authority::Abilities
  include AASM

  belongs_to :delivery_load

  scope :for_delivery_load, ->(delivery_load) {
    where(delivery_date: delivery_load.date, state: :unassigned).
    or(where(delivery_load: delivery_load))
  }

  scope :for_shift, ->(shift) { where(delivery_shift: shift) }
  scope :not_for_shift, ->(shift) { where.not(delivery_shift: shift).or(where(delivery_shift: nil)) }
  scope :overdue, -> { where('delivery_date < ?', Date.today) }

  aasm column: :state do
    state :need_checking
    state :unassigned, initial: true
    state :assigned
    state :performed

    event :invalidate do
      transitions to: :need_checking
    end

    event :check do
      transitions from: :need_checking, to: :unassigned
    end

    event :assign do
      transitions from: :unassigned, to: :assigned
    end

    event :perform do
      transitions from: :assigned, to: :performed
    end
  end

  def set_delivery_date
    self.delivery_date = original_delivery_date
    self.delivery_date = Date.today if delivery_date.blank? || overdue_date?
  end

  def address
    [destination_raw_line_1, destination_city, destination_zip].join(', ')
  end

  private

  def overdue_date?
    delivery_date.present? && delivery_date < Date.today
  end
end
