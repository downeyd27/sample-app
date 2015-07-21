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
end
