FactoryGirl.define do
  factory :user do
    name     "Bob Loblaw"
    email    "bobloblaw@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end