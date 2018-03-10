Clearance.configure do |config|
  config.routes = false
  config.allow_sign_up = true
  config.mailer_sender = "reply@example.com"
  config.rotate_csrf_on_sign_in = true
  config.password_strategy = Clearance::PasswordStrategies::BCrypt
  config.sign_in_guards = []
  config.user_model = User
  config.cookie_path = '/'
  config.redirect_url = '/'
end
