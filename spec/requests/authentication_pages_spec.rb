require 'rails_helper'

RSpec.describe "AuthenticationPages", type: :request do

  describe "GET signin_path" do
    before { get signin_path }

    it "has http status responds 200(OK)" do
      expect(response).to have_http_status(200)
    end

    it "renders sign up page view" do
      expect(response).to render_template(:new)
    end
  end

  describe "authorization" do
    describe "for non-signed-in-users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Relationships controller" do

        describe "submitting to the create action" do
          before { post relationships_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete relationship_path(1) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end
  end
end

