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

class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
end
