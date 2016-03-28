# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:comment) { build(:comment) }

  subject { comment }

  context 'attributes' do
    it { should respond_to(:post) }
    it { should respond_to(:text) }
  end

  context 'validations' do
    it { should validate_presence_of(:post) }
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text) }
  end

  context 'associations' do
    it { should belong_to(:post) }
  end
end
