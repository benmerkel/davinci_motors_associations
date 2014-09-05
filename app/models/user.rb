class User < ActiveRecord::Base
  has_secure_password
  validate :password, presence: true

  has_many :cars

  def owns?(car)
    self.cars.include?(car)
  end

  def needs_verification!
    self.update_attributes!(
      token: SecureRandom.urlsafe_base64,
      verified_email: false
    )
    UserNotifier.signed_up(self).deliver
  end

end
