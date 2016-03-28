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

  describe 'GET #show' do
    context 'when record is found' do
      let!(:comment) { create(:comment, post: post) }

      before :each do
        get "/api/v1/posts/#{post.id}/comments/#{comment.id}", {},
          'HTTP_AUTHORIZATION' => current_user_credentials
      end

      it 'should respond with 200' do
        expect(response.status).to eq(200)
      end

      it 'should render post json' do
        expect(json).to eq(
          comment: {
            id: comment.id,
            text: comment.text,
            post: {
              id: post.id
            }
          }
        )
      end
    end

    context 'when record is not found' do
      before :each do
        get "/api/v1/posts/#{post.id}/comments/-1", {},
          'HTTP_AUTHORIZATION' => current_user_credentials
      end

      it 'should respond with 404' do
        expect(response.status).to eq(404)
      end

      it 'should render json errors' do
        expect(json).to eq(
          error: {
            message: "Couldn't find Comment",
            class: 'ActiveRecord::RecordNotFound',
            status: 404
          }
        )
      end
    end
  end
end
