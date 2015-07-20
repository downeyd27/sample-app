require 'rails_helper'

RSpec.describe "UserPages", type: :feature do
  describe "User Pages" do

    describe "Sign-up Page" do
      before { visit signup_path }

      it { expect(page).to have_selector('h1', text: 'Sign up')}
      it { expect(page).to have_title 'Sign up'}
    end
  end
end
