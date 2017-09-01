source 'https://rubygems.org'

ruby '2.3.1'
gem 'rails', '~> 4.2.6'

gem 'administrate', '~> 0.1.4'
gem 'coffee-rails', '~> 4.1.0'
gem 'decent_exposure', '~> 2.3.3'
gem 'devise'
gem 'jquery-rails'
gem 'materialize-sass'
gem 'pg', '~> 0.18.4'
gem 'puma'
gem 'reform', '~> 2.1.0'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'
gem 'validates_timeliness'

group :production do
  gem 'newrelic_rpm'
  gem 'oj', '~> 2.12.14'
  gem 'rollbar'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'better_errors'
  gem 'faker'
  gem 'rubocop'
  gem 'poltergeist'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
end

group :development do
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'rails-footnotes', '~> 4.0'
  gem 'spring'
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'capybara', '~> 2.7.1'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.0'
  gem 'timecop',  '~> 0.8.1'
  gem 'launchy'
end
