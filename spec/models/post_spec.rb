# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:post) { build(:post) }

  subject { post }

  context 'attributes' do
    it { should respond_to(:user) }
    it { should respond_to(:text) }
  end

  context 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text) }
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
  end
end
