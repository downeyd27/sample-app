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
      it { expect(page).to have_link('Users', href: users_path) }
      it { expect(page).to have_link('Profile', href: user_path(user)) }
      it { expect(page).to have_link('Settings', href: edit_user_path(user)) }
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

    describe "authorization" do

      describe "for non-signed-in users" do

        describe "when attempting to visit a protected page" do
          before do
            visit edit_user_path(user)
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button 'Sign in'
          end

          describe "after signing in" do

            it "should render the desired protected page" do
              expect(page).to have_title 'Edit user'
            end
          end
        end

        describe "in the Users controller" do

          describe "visiting the edit page" do
            before { visit edit_user_path(user) }

            it { expect(page).to have_title 'Sign in' }
          end

          describe "visiting the user index" do
            before { visit users_path }

            it { expect(page).to have_title 'Sign in' }
          end
          # tests are within spec/feature/user_pages_spec.rb
          # Rspec test needs to be of type :request for put
          # action to be defined

          # describe "submitting to the update action" do
          #   # undefined method put error
          # before { put user_path(user) }
          # it { expect(response).to redirect_to(signin_path) }
          # end
        end
      end

      describe "as wrong user" do
        let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
        before { sign_in user }

        describe "visiting Users#edit page" do
          before { visit edit_user_path(wrong_user) }

          it { expect(page).to_not have_title 'Edit page' }
        end
      end
    end
  end
end
