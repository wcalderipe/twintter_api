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
#  role                   :integer          default("0")
#

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username_#{n}" }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    sequence(:email) { |n| "email_#{n}@twintter.com" }
    password 'password'
    password_confirmation 'password'
  end
end
