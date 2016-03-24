# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string           default(""), not null
#  first_name             :string           default(""), not null
#  last_name              :string           default(""), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  validates :username, :first_name, :last_name, presence: true
  validates :username, uniqueness: true

  devise :database_authenticatable, :registerable, :recoverable, :validatable

  enum role: [:guest, :user, :admin]
end
