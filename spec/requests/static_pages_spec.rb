require 'rails_helper'

RSpec.describe "Static Pages", type: :feature do

  shared_examples_for "all static pages" do
    it { expect(page).to have_title full_title(page_title) }
    it { expect(page).to have_selector('h1', text: heading) }
  end

  describe "Home Page" do
    before { visit root_path }
    let(:heading) { 'Home Page' }
    let(:page_title) { '' }

    it_should_behave_like 'all static pages'
    it { expect(page).to_not have_title '| Home'}
  end

  describe "Help Page" do
    before { visit help_path }
    let(:heading) { 'Help Page' }
    let(:page_title) { 'Help' }

    it_should_behave_like 'all static pages'
  end

  describe "About Page" do
    before { visit about_path }
    let(:heading) { 'About Us' }
    let(:page_title) { 'About Us' }

    it_should_behave_like 'all static pages'
  end

  describe "Contact Page" do
    before { visit contact_path }
    let(:heading) { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like 'all static pages'
  end
end
