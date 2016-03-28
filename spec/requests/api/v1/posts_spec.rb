require 'rails_helper'

RSpec.describe 'API V1 Posts', type: :request do
  describe 'GET #index' do
    let!(:user) { create(:user, role: :user) }
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
end

