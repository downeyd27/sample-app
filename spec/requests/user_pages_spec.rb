require 'rails_helper'

RSpec.describe "User pages", type: :feature do

  describe "sign-up page" do
    before { visit signup_path }

    it { expect(page).to have_title 'Sign Up'}
    it { expect(page).to have_selector('h1', text: 'Sign Up')}
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { expect(page).to have_title user.name }
    it { expect(page).to have_selector('h1', text: 'user.name') }
  end
end
