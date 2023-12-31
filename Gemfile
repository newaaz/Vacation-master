source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.8"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem "aasm", "~> 5.5"
gem "devise", "~> 4.9"
gem "faker", "~> 3.2"
gem "pundit", "~> 2.3"

group :development do
  gem "rack-mini-profiler"
  gem "web-console"

  # Deploy
  gem 'capistrano', '~> 3.11', require: false
  gem 'capistrano-passenger', '~> 0.2.0', require: false
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4', require: false
end

group :development, :test do
  gem "better_errors", "~> 2.10"
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails", "~> 6.2"
  gem "letter_opener", "~> 1.8"
  gem "rails-controller-testing", "~> 1.0"
  gem "rspec-rails", "~> 6.0"
  gem "rubocop", "~> 1.57", require: false
  gem "rubocop-performance", "~> 1.19", require: false
  gem "rubocop-rails", "~> 2.21", require: false
  gem "rubocop-rspec", "~> 2.24", require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "webdriver", "~> 0.19.0"
  # gem "gem", "~> 0.0.1.alpha"
  gem "database_cleaner-active_record", "~> 2.0"
  gem "launchy", "~> 2.5"
  gem 'pundit-matchers', '~> 1.8.4'
  gem "selenium-webdriver", "~> 4.14"
  gem "shoulda-matchers", "~> 5.2"
  gem 'simplecov', require: false
end
