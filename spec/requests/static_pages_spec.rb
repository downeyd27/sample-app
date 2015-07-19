require 'rails_helper'

RSpec.describe "StaticPages Controller", type: :feature do
  describe "Home Page" do
    before { visit root_path }

    it "should have the title 'Home'" do
      expect(page).to have_title 'Home'
    end

    it "should have the h1 'Home'" do
      expect(page).to have_selector('h1', text: 'Home Page')
    end
  end

  describe "Help Page" do
    before { visit help_path }
    it "should have the title 'Help'" do
      expect(page).to have_title 'Help'
    end

    it "should have the h1 'Help'" do
      expect(page).to have_selector('h1', text: 'Help')
    end
  end

  describe "About Page" do
    before { visit about_path }
    it "should have the h1 'About Us'" do
      expect(page).to have_selector('h1', text: 'About Us')
    end

    it "should have the title 'About Us'" do
      expect(page).to have_title 'About Us'
    end
  end

  describe "Contact Page" do
    before { visit contact_path }
    it "should have the h1 'Contact'" do
      expect(page).to have_selector('h1', text: 'Contact')
    end

    it "should the title 'Contact'" do
      expect(page).to have_title 'Contact'
    end
  end
end
