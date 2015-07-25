require 'rails_helper'

RSpec.describe "MicropostPages", type: :request do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }
  end

  describe "with invalid information" do
    it "should not create a micropost" do
      expect { click_button 'Post' }.not_to change(Micropost, :count)
    end

    describe "error message" do
      before { click_button 'Post' }
      it { expect(page).to have_content 'error' }
    end
  end
end
