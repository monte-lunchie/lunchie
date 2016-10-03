Rails.application.config.middleware.use OmniAuth::Builder do
  # yep, those should be env variables
  provider :github, '65c2c9d6c5ad7049b4bf', 'f5d6279515d1cf4fda92ef4c5c2cd451cef4f85e', scope: 'user'
end
