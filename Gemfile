# frozen_string_literal: true

source 'https://rubygems.org'

gem 'bootsnap', require: false
gem 'devise_invitable'
gem 'devise-jwt'
gem 'file_exists'
gem 'image_processing'
gem 'importmap-rails'
gem 'jbuilder'
gem 'maintenance_tasks'
gem 'motor-admin'
gem 'oj'
gem 'pagy'
gem 'passpartu'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'pundit'
gem 'rack-cors'
gem 'rails', '~> 8.0.1'
gem 'r_creds'
gem 'readymade'
gem 'redis'
gem 'rspec_api_documentation'
gem 'sidekiq'
gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'stimulus-rails'
gem 'tailwindcss-rails', '~> 3.3.1'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[windows jruby]
gem 'xlog'

group :development, :test do
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'rubocop-rails-omakase', require: false
end

group :development do
  gem 'brakeman'
  gem 'bullet'
  gem 'rubocop'
  gem 'rubycritic'
  gem 'web-console'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-rails', '~> 4.0', '>= 4.0.1'
  gem 'rspec-sidekiq'
  gem 'webmock'
end
