source 'https://rubygems.org'

# Version of Ruby Language
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'

# PostgreSQL database
gem 'pg', '0.18.2'

# Bootstrap Sass style
gem 'bootstrap-sass', '3.3.5.1'

# Allows you to control how many of a list is displayed.
# If you don't want to see all 1000 users on your users index
# page this may be useful
gem 'will_paginate'

# allows bootstrap to pagination
gem 'will_paginate-bootstrap'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '4.0.4'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '2.3.1'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '0.4.1', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '3.1.10'

# Faker gem to make sample users with semi-realistic names and email addresses
gem 'faker', '1.4.3'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # RSPEC for testing in rails
  gem 'rspec-rails', '3.3.3'

  # Adds rspec method its back which was removed in RSpec 3.0
  gem 'rspec-its'

  #shoulda-matchers provides Test::Unit- and RSpec-compatible one-liners that test common Rails functionality.
  gem 'shoulda-matchers', '~> 3.0.0.rc1'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '1.3.10'


  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '5.0.0'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '2.2.1'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

end

# Gems used only for assets and not required
# in production environments by default.
group :assets do

  # Use SCSS for stylesheets
  gem 'sass-rails', '5.0.3'

  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '2.7.1'

  # Use CoffeeScript for .coffee assets and views
  gem 'coffee-rails', '4.1.0'

end

group :test do

  # Capybara helps you test web applications by simulating how a real user would interact with your app.
  gem 'capybara', '2.4.4'


  # factory_girl is a fixtures replacement with a straightforward definition syntax, support for multiple build strategies (saved instances, unsaved instances, attribute hashes, and stubbed objects), and support for multiple factories for the same class (user, admin_user, and so on), including factory inheritance.
  gem 'factory_girl_rails', '4.5.0'

  gem 'cucumber-rails', '1.4.2', :require => false

  # Database Cleaner is a set of strategies for cleaning your database in Ruby
  gem 'database_cleaner', '1.4.1'
end

group :production do
  # This gem enables serving assets in production and setting your logger to standard out, both of which are required to run a Rails 4 application on a twelve-factor provider.  Heroku recommendation.
  gem 'rails_12factor'
end

group :development do
  # rails_layout gem adds an updated foundation to the rails layout
  gem 'rails_layout'

  gem 'pry-rails'
  # annotate provides a schema design within models
  gem 'annotate', '2.6.10'
end