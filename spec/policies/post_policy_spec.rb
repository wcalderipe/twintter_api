require 'rails_helper'

describe PostPolicy do
  let!(:current_user) { build(:user, role: :user) }
  let!(:guest) { build(:user) }
  let!(:user) { build(:user, role: :user) }
  let!(:admin) { build(:user, role: :admin) }

  subject { PostPolicy }

  permissions :index?, :show? do
    it 'grants access to guests' do
      expect(subject).to permit(guest)
    end

    it 'grants access to users' do
      expect(subject).to permit(user)
    end

    it 'grants access to admins' do
      expect(subject).to permit(admin)
    end
  end
end
