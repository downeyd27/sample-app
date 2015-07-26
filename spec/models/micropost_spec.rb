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
    @micropost = user.microposts.build(content: "Lorem ipsum")
  end

  subject { @micropost }

  it { expect(subject).to respond_to(:content) }
  it { expect(subject).to respond_to(:user_id) }
  it { expect(subject).to respond_to(:user) }
  # its

  it { expect(subject).to be_valid }

  describe "when a user_id is not present" do
    before { @micropost.user_id = nil }
    it { expect(subject).to be_invalid }
  end

  describe "with blank content" do
    before { @micropost.content = ' ' }
    it { expect(@micropost).to_not be_valid}
  end

  describe "with content that is too long" do
    before { @micropost.content = 'z' * 141 }
    it { expect(@micropost).to_not be_valid}
  end

  describe  "when a user_id is not present" do
    before { @micropost.user_id = nil }
    it { expect(@micropost).to_not be_valid }
  end
end
