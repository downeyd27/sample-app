# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do

  before { @user = User.new(name: "Test User", email: "test@user.com") }

  it { expect(@user).to respond_to(:name) }
  it { expect(@user).to respond_to(:email) }
end
