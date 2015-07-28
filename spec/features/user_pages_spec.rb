require 'rails_helper'

RSpec.describe "User pages", type: :feature do
  # Refactor so that FactoryGirl user is within the scope of a describe block.  Do some research first, but I wonder if
  # it can interfer with scope of user with some of the tests.
  let(:user) { FactoryGirl.create(:user) }

  describe "index" do

    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { expect(page).to have_title 'All users' }
    it { expect(page).to have_selector('h1', text: 'All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) }}
      after(:all)  { User.delete_all }

      it { expect(page).to have_selector('ul.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do

      it { expect(page).to_not have_link('delete') }

      describe "as an admin user" do

        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { expect(page).to have_link('delete', href: user_path(User.first)) }

        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end

        it { expect(page).not_to have_link('delete', href: user_path(admin)) }
      end
    end
  end

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

          it { expect(page).to have_title 'Sign up' }
          it { expect(page).to have_content('error') }
        end
      end

      describe "with valid information" do

        before do
          # change to with: user.name, etc, and test later
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

      it { expect(page).to have_title 'Sign up'}
      it { expect(page).to have_selector('h1', text: 'Sign up')}
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

      before { click_button 'Save changes' }
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

      it { expect(page).to have_title 'New Name' }
      it { expect(page).to have_selector('h1', 'Update your profile') }
      it { expect(page).to have_selector('div.alert.alert-success') }
      it { expect(page).to have_link('Sign out', href: signout_path) }

      before { user.reload }

      specify { expect(user.name).to eq new_name }
      specify { expect(user.email).to eq new_email }
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }

    let!(:micro_1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:micro_2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }
    before { visit user_path(user) }

    it { expect(page).to have_title user.name }
    it { expect(page).to have_selector('h1', text: user.name) }


    describe "microposts" do
      it { expect(page).to have_content micro_1.content }
      it { expect(page).to have_content micro_2.content }
      it { expect(page).to have_content user.microposts.count }

      describe "association status" do
        let(:unfollowed_post) do
          FactoryGirl.create(:micropost, user: user)
        end

        it { expect(user.feed).to_not have_content(unfollowed_post) }
        # failing tests
        it { expect(user.feed).to have_content(micro_1.content) }
        it { expect(user.feed).to have_content(micro_2.content) }
      end
    end

    describe "follow/unfollow buttons" do
      let(:other_user) { FactoryGirl.create(:user) }
      before { sign_in user }

      describe "following a user" do
        before { visit user_path(other_user) }

        it "should increment the followed user count" do
          expect do
            click_button "Follow"
          end.to change(user.followed_users, :count).by(1)
        end

        it "should increment the other user's followers count" do
          expect do
            click_button "Follow"
          end.to change(other_user.followers, :count).by(1)
        end

        describe "toggling the button" do
          before { click_button "Follow" }
          it { should have_selector('input', value: 'Unfollow') }
        end
      end

      describe "unfollowing a user" do
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end

        it "should decrement the followed user count" do
          expect do
            click_button "Unfollow"
          end.to change(user.followed_users, :count).by(-1)
        end

        it "should decrement the other user's followers count" do
          expect do
            click_button "Unfollow"
          end.to change(other_user.followers, :count).by(-1)
        end

        describe "toggling the button" do
          before { click_button "Unfollow" }
          it { should have_selector('input', value: 'Follow') }
        end
      end
    end
  end

  describe "following/followers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }

    describe "followed users" do
      before do
        sign_in user
        visit following_user_path(user)
      end

      it { expect(page).to have_title full_title('Following') }
      it { expect(page).to have_selector('h3', text: 'Following') }
      it { expect(page).to have_link(other_user.name, href: user_path(other_user)) }
    end

    describe "followers" do
      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end

      it { expect(page).to have_title full_title('Followers') }
      it { expect(page).to have_selector('h3', text: 'Followers') }
      it { expect(page).to have_link(user.name, href: user_path(user)) }
    end
  end
end
