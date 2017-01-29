class Order < ApplicationRecord
  include Authority::Abilities
  include AASM

  belongs_to :delivery_load

  aasm column: :state do
    state :need_checking
    state :unassigned, initial: true
    state :assigned
    state :performed
    state :overdue

    event :invalidate do
      transitions to: :need_checking
    end

    event :check do
      transitions from: :need_checking, to: :unassigned
    end

    event :assigne do
      transitions from: :unassigned, to: :assigned
    end

    event :perform do
      transitions from: :assigned, to: :performed
    end

    event :delay do
      transitions from: :unassigned, to: :overdue
    end
  end
end
