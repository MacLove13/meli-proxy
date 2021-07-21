ENV['SERVICE_URL'] ||= 'https://api.stackexchange.com'

Rails.application.config.middleware.use ApplicationServiceProxy, backend: ENV['SERVICE_URL'], streaming: false
