require 'rails_helper'

RSpec.describe "StaticPages Controller", type: :feature do

  describe "Home Page" do
    before { visit root_path }

    it { expect(page).to have_title full_title('')}
    it { expect(page).to have_selector('h1', text: 'Home Page') }
  end

  describe "Help Page" do
    before { visit help_path }

     it { expect(page).to have_title full_title('Help') }
     it { expect(page).to have_selector('h1', text: 'Help')}
  end

  describe "About Page" do
    before { visit about_path }

    it { expect(page).to have_title full_title('About Us') }
    it { expect(page).to have_selector('h1', text: 'About Us')}
  end

  describe "Contact Page" do
    before { visit contact_path }
    it { expect(page).to have_title full_title('Contact') }
    it { expect(page).to have_selector('h1', text: 'Contact')}
  end
end
