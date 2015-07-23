require 'rails_helper'

RSpec.describe "Authentication", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  describe 'signin page' do
    before { visit signin_path }

    it { expect(page).to have_title 'Sign in' }
    it { expect(page).to have_selector( 'h1', text: 'Sign in') }
    it { expect(page).to have_link('Sign up now!', href: signup_path) }

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase # upcase so that we make sure use in database is case-insensitive
        fill_in "Password", with: user.password
        click_button 'Sign in'
      end

      it { expect(page).to have_title user.name }
      it { expect(page).to have_selector('div.alert.alert-success', text: 'Valid') }
      it { expect(page).to have_link('Profile', href: user_path(user)) }
      it { expect(page).to have_link('Sign out', href: signout_path) }
      it { expect(page).to_not have_link('Sign in', href: signin_path) }


      describe "followed by signout" do
        before { click_link "Sign out" }

        it { expect(page).to have_link('Sign in') }
        it { expect(page).to have_selector('div.alert.alert-success', text: "Logged out!")}
      end
    end

    describe "with invalid information" do
      before { click_button 'Sign in' }

      it { expect(page).to have_title 'Sign in' }
      it { expect(page).to have_selector('div.alert.alert-error', text: 'Invalid') }

      describe "after visiting another page" do
        before { click_link 'Home' }

        it { expect(page).to_not have_selector('div.alert.alert-error') }
      end
    end
  end
end
