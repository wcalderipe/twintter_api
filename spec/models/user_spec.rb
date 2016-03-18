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
  end

  context 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  context 'associations' do
  end
end
