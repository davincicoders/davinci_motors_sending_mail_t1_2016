# Preview all emails at http://localhost:3000/rails/mailers/user_notifier
class UserNotifierPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_notifier/signed_up
  def signed_up
    UserNotifier.signed_up
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_notifier/verified
  def verified
    UserNotifier.verified
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_notifier/verify
  def verify
    UserNotifier.verify
  end

end
