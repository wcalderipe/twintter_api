require 'rails_helper'

describe PostPolicy do
  let!(:current_user) { create(:user, role: :user) }
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

  permissions :create?, :update? do
    let!(:post) { build(:post, user: current_user) }

    it 'grants access to users' do
      expect(subject).to permit(current_user, post)
    end

    it 'grants access to admins' do
      expect(subject).to permit(admin, post)
    end

    it 'denies access to guests' do
      expect(subject).not_to permit(guest, post)
    end

    it 'denies access to users using others user id' do
      expect(subject).not_to permit(user, post)
    end
  end
end
