source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma'

# API
gem 'active_model_serializers', github: 'rails-api/active_model_serializers'

# gem 'foreman', require: false

# Validate
gem 'dry-struct' # , github: 'dry-rb/dry-struct'
gem 'dry-types', '~> 0.9', github: 'dry-rb/dry-types'
gem 'dry-validation', github: 'dry-rb/dry-validation'

# JSON
gem 'oj'
gem 'oj_mimic_json'

# Logs
gem 'lograge'

# Protection
gem 'rack-protection'
gem 'rack-attack'
gem 'rack-cors'
gem 'rack-timeout', require: 'rack/timeout/base'

# Cache
gem 'dalli'

group :development, :test do
  gem 'ruby-debug-ide'
  gem 'debase'

  gem 'factory_girl_rails', '~> 4.5'

  gem 'rubocop', require: false
  gem 'brakeman', require: false

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug'

  # Use Capistrano for deployment
  # gem 'capistrano-rails', group: :development

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'coveralls'

  gem 'rspec-rails', '~> 3.5.0.beta3'
end

gem 'json_schema'

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'

  gem 'shoulda-matchers', '3.1.1', require: false
  gem 'rails-controller-testing', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
