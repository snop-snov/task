class DeliveryLoadAuthorizer < ApplicationAuthorizer
  def self.default(adjective, user)
    user.dispatcher?
  end

  def downloadable_by?(user)
    resource.driver == user
  end
end
