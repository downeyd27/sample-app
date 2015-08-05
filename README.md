## Synopsis

This project is intended to be a simple replication of twitter.  You have the ability to create an account where you can sign in and sign out with proper authentication and authorization.  You can also create "microposts", follow and unfollow other users, change a gravatar profile photo, and view a feed of the posts of those who you follow.

## Motivation

This project was intended for me to further learn how to properly sign in a user with authentication and authorization along with emphasizing on test driven development.  This project gave me a lot of insight on separtion of concerns within the Ruby on Rails framework with helpers, partials, and a variety of gems new to me.

## Setting up Environment

Ruby 2.0.0
Rails 4.2.3
# Gems

will_paginate
Capybara
shoulda-matchers
bootstrap-sass
factory_girl_rails
pry-rails
rails_layout
annotate

## How to use

This app can be used [here](https://something-like-twitter.herokuapp.com/) on Heroku.

## Developing

If you would like to work on developing this project.

1 Fork the project
2 Run  ```rake db:reset, rake db:populate, and rake db:test:prepare```
3 Write tests for changes
4 Make Changes
5 Submit a pull request with well documented notes on why the changes where made.

## Read License


