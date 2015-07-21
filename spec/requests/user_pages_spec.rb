require 'rails_helper'

RSpec.describe "UserPages", type: :request do

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
    let(:user) { FactoryGirl.create(:user) }
    before { get user_path(user) }

    it "has http status responds 200(OK)" do
      expect(response).to have_http_status(200)
    end

    it "renders show page view" do
      expect(response).to render_template(:show)
    end
  end
end
