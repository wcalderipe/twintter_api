require 'rails_helper'

RSpec.describe 'API V1 Comments', type: :request do
  let!(:post) { create(:post) }

  describe 'GET #index' do
    let!(:comments_collection) { create_list(:comment, 2, post: post) }

    before :each do
      get "/api/v1/posts/#{post.id}/comments", {},
        'HTTP_AUTHORIZATION' => current_user_credentials
    end

    it 'should respond with 200' do
      expect(response.status).to eq(200)
    end

    it "should render post's comments json collection" do
      expect(json).to eq(
        comments: [
          {
            id: comments_collection[1].id,
            text: comments_collection[1].text,
          },
          {
            id: comments_collection[0].id,
            text: comments_collection[0].text,
          }
        ],
        meta: {
          total: 2,
          page: nil,
          per_page: 5
        }
      )
    end
  end
end
