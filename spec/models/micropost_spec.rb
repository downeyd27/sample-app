# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Micropost, type: :model do

  let(:user) { FactoryGirl.create(:user) }
  before do
    # wrong
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: user.id)
  end

  subject { @micropost }

  it { expect(subject).to respond_to(:content) }
  it { expect(subject).to respond_to(:user_id) }
  it { expect(subject).to respond_to(:user) }
  # its

  it { expect(subject).to be_valid }

  describe "when a user_id is not present" do
    before { subject.user_id = nil }
    it { expect(subject).to be_invalid }
  end

  describe  "when a user_id is present" do
    before { subject.user_id = nil }
    it { expect(subject).to_not be_valid }
  end
end
