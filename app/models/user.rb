class User < ActiveRecord::Base
  has_secure_password(validations: false)

  has_many :cars

  validates_confirmation_of :password, if: ->(user) { !user.omniauth? && user.password.present? }
  validates_presence_of :password, on: :create, if: ->(user) { !user.omniauth? }
  validates_presence_of :password_confirmation, if: ->(user) { !user.omniauth? && user.password.present? }

  def needs_verification!
    self.update_attributes(
      verified_email: false,
      token: SecureRandom.urlsafe_base64
    )
    UserNotifier.signed_up(self).deliver_now
  end

  def verify!
    self.update_attributes(
      verified_email: true,
      token: ''
    )
    UserNotifier.verified(self).deliver_now
  end
end

