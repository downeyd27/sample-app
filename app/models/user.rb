# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  name                  :string
#  email                 :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  password_digest       :string
#  password              :string
#  password_confirmation :string
#  remember_token        :string
#  admin                 :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy

  # downcase email before saving because not all database adapters use case-sensitive indices
  before_save { email.downcase! }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # No need to put in presence true for password because password_confirmation
  # uses has_secure_password to validate presence of password.
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def feed
    # Preliminary. Not full implementation
    Micropost.where("user_id = ?", id)
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
  # end of private methods
end
