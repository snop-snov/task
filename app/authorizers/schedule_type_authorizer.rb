class ScheduleTypeAuthorizer < ApplicationAuthorizer
  def self.default(adjective, user)
    user.role == 'dispatcher'
  end
end