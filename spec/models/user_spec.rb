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

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { build(:user) }

  subject { user }

  context 'attributes' do
    it { should respond_to(:username) }
    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:email) }
    it { should respond_to(:password) }
    it { should respond_to(:reset_password_token) }
    it { should respond_to(:role) }
  end

  context 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  context 'associations' do
    it { should have_many(:posts) }
  end

  describe 'role' do
    it 'should be guest as default role' do
      expect(user.role).to eq('guest')
    end
  end
end
