class DeliveryLoadAuthorizer < ApplicationAuthorizer
  def self.default(adjective, user)
    user.dispatcher?
  end
end
