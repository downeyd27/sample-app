require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

  describe "GET home" do
    before { get root_path }

    it "has http status responds 200(OK)" do
      expect(response).to have_http_status(200)
    end

    it "renders home page view" do
      expect(response).to render_template(:home)
    end
  end

  describe "GET help" do
    before { get help_path }

    it "has http status responds 200(OK)" do
      expect(response).to have_http_status(200)
    end

    it "renders help page view" do
      expect(response).to render_template(:help)
    end
  end

  describe "GET about" do
    before { get about_path }

    it "has http status responds 200(OK)" do
      expect(response).to have_http_status(200)
    end

    it "renders about page view" do
      expect(response).to render_template(:about)
    end
  end

  describe "GET contact" do
    before { get contact_path }

    it "has http status responds 200(OK)" do
      expect(response).to have_http_status(200)
    end

    it "renders contact page view" do
      expect(response).to render_template(:contact)
    end
  end
end
