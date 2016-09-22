class ApplicationSchema < Dry::Validation::Schema
  configure do
    config.messages_file = 'config/locales/errors.yml'
    config.messages = :i18n
  end
end
