require 'rails_helper'

RSpec.describe "User pages", type: :feature do
  describe "User Pages" do

    describe "sign-up page" do
      before { visit signup_path }

      it { expect(page).to have_title 'Sign Up'}
      it { expect(page).to have_selector('h1', text: 'Sign Up')}
    end

    describe "profile page" do
      before { visit user_path(user) }

      it { expect(page).to have_title text: 'user.name' }
      it { expect(page).to have_selector('h1', text: 'user.name') }
    end
  end
end
