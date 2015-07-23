require 'rails_helper'

RSpec.describe "User pages", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account"}

    describe "page" do
      describe "with invalid information" do
        it "should not create user" do
          expect { click_button submit }.not_to change(User, :count)
        end

        describe "after submission" do
          before { click_button submit }

          it { expect(page).to have_title 'Sign Up' }
          it { expect(page).to have_content('error') }
        end
      end

      describe "with valid information" do
        before do
          fill_in "Name", with: "Test User"
          fill_in "Email", with: "user@example.com"
          fill_in "Password", with: "foobar"
          fill_in "Confirm Password", with: "foobar"
        end

        it "should create user" do
          expect { click_button submit }.to change(User, :count).by(1)
        end

        describe "after saving the user" do
          before { click_button submit }
          let(:user) { User.find_by_email('user@example.com') }

          it { expect(page).to have_title user.name }
          it { expect(page).to have_selector('div.alert.alert-success', text: 'Welcome') }
        end
      end

      it { expect(page).to have_title 'Sign Up'}
      it { expect(page).to have_selector('h1', text: 'Sign Up')}
    end
  end

  describe "profile" do
    before { visit user_path(user) }

    describe "page" do
      it { expect(page).to have_title user.name }
      it { expect(page).to have_selector('h1', text: user.name) }
    end
  end

  describe "edit" do
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { expect(page).to have_title 'Edit user' }
      it { expect(page).to have_selector('h1', text: 'Update your profile') }
      it { expect(page).to have_link('change', href: 'https://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button 'Save Changes' }

      it { expect(page).to have_content 'error' }
    end

    describe "with valid information" do
      let(:new_name) { 'New Name' }
      let(:new_email) { 'new@example.com' }

      before  do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button 'Save changes'
      end
    end

    it { expect(page).to have_title 'new_name' }
    it { expect(page).to have_selector('h1', 'Update your profile') }
    it { expect(page).to have_selector('div.alert.alert-success') }
    it { expect(page).to have_link('Sign out', href: signout_path) }
    specify { epexct(user.reload.name).to == name_name }
    specify { epexct(user.reload.email).to == new_email }
  end
end
