require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "Home Page" do
    it "should have the content 'Home Page'" do
      visit '/static_pages/home'
      page.should have_content('Home Page')
    end
  end
end
