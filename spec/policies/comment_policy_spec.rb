require 'rails_helper'

describe CommentPolicy do
  let!(:current_user) { create(:user, role: :user) }
  let!(:guest) { build(:user) }
  let!(:user) { build(:user, role: :user) }
  let!(:admin) { build(:user, role: :admin) }

  subject { CommentPolicy }

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
    let!(:comment) { build(:comment) }

    it 'grants access to users' do
      expect(subject).to permit(user, comment)
    end

    it 'grants access to admins' do
      expect(subject).to permit(admin, comment)
    end

    it 'denies access to guests' do
      expect(subject).not_to permit(guest, comment)
    end
  end

  permissions :update?, :destroy? do
    let!(:post) { create(:post, user: current_user) }
    let!(:comment) { build(:comment, post: post) }

    it 'grants access to users own comments' do
      expect(subject).to permit(current_user, comment)
    end

    it 'grants access to admins' do
      expect(subject).to permit(admin, comment)
    end

    it 'denies access to guests' do
      expect(subject).not_to permit(guest, comment)
    end

    it 'denies access to users in other users comments' do
      expect(subject).not_to permit(user, comment)
    end
  end
end
