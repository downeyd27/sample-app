require 'rails_helper'

RSpec.describe Micropost, type: :model do

  let(:user) { FactoryGirl.create(:user) }
  before do
    # this code is wrong
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: user.id)
  end

  subject { @micropost }

  it { expect(subject).to respond_to(:content) }
  it { expect(subject).to respond_to(:user_id) }

  it { expect(subject).to be_valid }

  describe "when a user_id is not present" do
    before { @micropost.user_id = nil }
    it { expect(subject).to be_invalid }
  end
end
