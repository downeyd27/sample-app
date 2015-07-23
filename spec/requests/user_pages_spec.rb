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

    describe "authorization for non-signed-in users in the Users controller after submitting to the update action" do

      before { put user_path(user) }

      it { expect(response).to redirect_to(signin_path) }
    end
  end
end
