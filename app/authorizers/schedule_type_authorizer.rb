class ScheduleTypeAuthorizer < ApplicationAuthorizer
  def self.default(adjective, user)
    user.dispatcher?
  end

  def self.readable_by?(user)
    user.driver?
  end
end
