class UserSignInType < ActiveType::Object
  attribute :email, :string
  attribute :password, :string

  validates :email, presence: true
  validates :password, presence: true
  validate :check_authenticate, if: :email

  def user
    ::User.find_by(email: email.mb_chars.downcase)
  end

  private

  def check_authenticate
    if !user.try(:authenticate, password)
      errors.add(:password, :user_or_password_invalid)
    end
  end
end
