require 'rails_helper'

RSpec.describe 'API V1 Posts', type: :request do
  let!(:user) { create(:user, role: :user) }

  describe 'GET #index' do
    let!(:posts_collection) { create_list(:post, 2, user: user) }

    before :each do
      get "/api/v1/users/#{user.id}/posts", {},
        'HTTP_AUTHORIZATION' => current_user_credentials
    end

    it 'should respond with 200' do
      expect(response.status).to eq(200)
    end

    it "should render user's posts json collection" do
      expect(json).to eq(
        posts: [
          {
            id: posts_collection[1].id,
            text: posts_collection[1].text,
            user: {
              id: user.id
            }
          },
          {
            id: posts_collection[0].id,
            text: posts_collection[0].text,
            user: {
              id: user.id
            }
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
      let!(:post) { create(:post, user: user) }

      before :each do
        get "/api/v1/users/#{user.id}/posts/#{post.id}", {},
          'HTTP_AUTHORIZATION' => current_user_credentials
      end

      it 'should respond with 200' do
        expect(response.status).to eq(200)
      end

      it 'should render post json' do
        expect(json).to eq(
          post: {
            id: post.id,
            text: post.text,
            user: {
              id: user.id
            }
          }
        )
      end
    end

    context 'when record is not found' do
      before :each do
        get "/api/v1/users/#{user.id}/posts/-1", {},
          'HTTP_AUTHORIZATION' => current_user_credentials
      end

      it 'should respond with 404' do
        expect(response.status).to eq(404)
      end

      it 'should render json errors' do
        expect(json).to eq(
          error: {
            message: "Couldn't find Post",
            class: 'ActiveRecord::RecordNotFound',
            status: 404
          }
        )
      end
    end
  end
end

