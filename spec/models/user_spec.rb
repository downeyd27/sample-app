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

  before do
    @user = User.new(name: "Example User", email: "user@test.com", password: "foobar", password_confirmation: "foobar")
  end


  it { expect(@user).to respond_to(:name) }
  it { expect(@user).to respond_to(:email) }
  it { expect(@user).to respond_to(:password_digest) }
  it { expect(@user).to respond_to(:password) }
  it { expect(@user).to respond_to(:password_confirmation) }

  it { expect(@user).to be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { expect(@user).to_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { expect(@user).to_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "Z" * 51 }
    it { expect(@user).to_not be_valid}
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).to_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { expect(@user).to_not be_valid }
  end

  describe "when password is not present" do
    before { @user.passowrd = @user.password_confirmation = " "}
    it { expect(@user).to_not be_valid }
  end

  describe "when password doesn't match confirmation password" do
    before { @user.password_confirmation = "mismatch" }
    it { expect(@user).to_not be_valid }
  end

  describe "when password_confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { expect(@user).to_not be_valid }
  end
end
