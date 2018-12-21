source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'rails', '~> 5.2.1'
gem 'bcrypt',  '3.1.12'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'carrierwave',    '1.2.3'
gem 'mini_magick', '4.9.2'
gem 'bootstrap', '~> 4.1', '>= 4.1.3'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'simple_form'


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Rspec rails
  gem 'rspec-rails', '~> 3.8'
  gem 'rails-controller-testing'
  gem 'faker' 
  gem 'hirb'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Database cleaner
  gem 'database_cleaner'
  # Capybara
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'rack_session_access'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
