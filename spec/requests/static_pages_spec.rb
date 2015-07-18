require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

RSpec.describe "StaticPages", type: :feature do
  describe "Home Page" do

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_selector('title', text: 'Home')
    end

    it "should have the h1 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_selector('h1', text: 'Home')
    end
  end

  describe "Help Page" do

    it "should have the h1 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_selector('h1', text: 'Help')
    end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_selector('title', text: 'Help')
    end
  end

  describe "About Page" do

    it "should have the h1 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_selector('h1', text: 'About Us')
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_selector('title', text: 'About Us')
    end
  end
end
