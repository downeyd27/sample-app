require 'rails_helper'

RSpec.describe "UserPages", type: :request do
  let(:user) { FactoryGirl.create(:user) }

  describe "GET new" do
    before { get new_user_path }

    it "has http status responds 200(OK)" do
      expect(response).to have_http_status(200)
    end

    it "renders user new (sign up) page view" do
      expect(response).to render_template(:new)
    end
  end

  describe "GET show" do
    before { get user_path(user) }

    it "has http status responds 200(OK)" do
      expect(response).to have_http_status(200)
    end

    it "renders show page view" do
      expect(response).to render_template(:show)
    end
  end

  describe "PUT edit" do

    describe "authorization" do

      describe "for non-signed-in users in the Users controller after submitting to the update action" do

        before { put user_path(user) }
        it { expect(response).to redirect_to(signin_path) }
      end
      #
      # TEST NOT WORKING BECAUSE 'NO ROUTE MATCHES USERS/512/EDIT'
      #
      describe "as a wrong user submitting a PUT request to the Users#update action" do
        let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
        before { sign_in user, no_capybara: true }
        before { put edit_user_path(wrong_user) }
        it { expects(response).to redirect_to(root_url) }
      end
    end
  end

  describe "authorization" do

    describe "DELETE user" do

      #
      # TEST NOT WORKING BECAUSE 'NO ROUTE MATCHES USERS.512'
      #
      describe "as non-admin user" do
        let(:user) { FactoryGirl.create(:user) }
        let(:non_admin) { FactoryGirl.create(:user) }

        before { sign_in non_admin, no_capybara: true }

        describe "submitting a DELETE requesst to the Users#destroy action" do
          before { delete users_path(user) }
          it { expect(response).to redirect_to root_url }
        end
      end

      describe "in the Microposts controller" do

        describe "submitting to the create action" do
          before { post microposts_path }
          it { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)), {} }
          it { expect(response).to redirect_to(signin_path) }
        end
      end
    end
  end
end
