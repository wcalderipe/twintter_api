require 'rails_helper'

describe UserPolicy do
  let!(:current_user) { build(:user, role: :user) }
  let!(:guest) { build(:user) }
  let!(:user) { build(:user, role: :user) }
  let!(:admin) { build(:user, role: :admin) }

  subject { UserPolicy }

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

  permissions :create? do
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

  permissions :update?, :destroy? do
    it 'grants access to admins over guests' do
      expect(subject).to permit(admin, guest)
    end

    it 'grants access if admin is himself' do
      expect(subject).to permit(admin, admin)
    end

    it 'grants access if user is himself' do
      expect(subject).to permit(current_user, current_user)
    end

    it 'grants access if user is himself' do
      expect(subject).to permit(current_user, current_user)
    end

    it 'denies access if user is not himself' do
      expect(subject).not_to permit(current_user, user)
    end

    it 'denies access if admin is not himself' do
      expect(subject).not_to permit(admin, build(:user, role: :admin))
    end

    it 'denies access to guests' do
      expect(subject).not_to permit(guest)
    end
  end

  permissions :destroy? do
  end
end
