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
end
