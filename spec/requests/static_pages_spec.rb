require 'rails_helper'

RSpec.describe "StaticPages Controller", type: :feature do
  describe "Home Page" do

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title 'Home'
    end

    it "should have the h1 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_selector('h1', text: 'Home Page')
    end
  end

  describe "Help Page" do

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title 'Help'
    end

    it "should have the h1 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_selector('h1', text: 'Help')
    end
  end

  describe "About Page" do

    it "should have the h1 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_selector('h1', text: 'About Us')
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_title 'About Us'
    end
  end

  describe "Contact Page" do
    it "should have the h1 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_selector('h1', text: 'Contact')
    end

    it "should the title 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_title 'Contact'
    end
  end
end
