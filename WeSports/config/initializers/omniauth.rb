Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, '160700188817-um32jcu61n5d88hgnqv8hr5k88lepmkr.apps.googleusercontent.com', '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', :skip_jwt => true
end