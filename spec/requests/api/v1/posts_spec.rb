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

  describe 'POST #create' do
    context 'with valid attributes' do
      let!(:post_attributes) { { text: FFaker::Lorem.word } }

      before :each do
        post "/api/v1/users/#{user.id}/posts", { post: post_attributes },
          'HTTP_AUTHORIZATION' => current_user_credentials
      end

      it 'should respond with 201' do
        expect(response.status).to eq(201)
      end

      it 'should render user json' do
        expect(json).to eq(
          post: {
            id: Post.last.id,
            text: post_attributes[:text],
            user: {
              id: user.id
            }
          }
        )
      end
    end

    context 'with invalid attributes' do
      let(:post_attributes) { { text: '' } }

      before :each do
        post "/api/v1/users/#{user.id}/posts", { post: post_attributes },
          'HTTP_AUTHORIZATION' => current_user_credentials
      end

      context 'missing text' do
        it 'should respond with 422' do
          expect(response.status).to eq(422)
        end

        it 'should render json errors' do
          expect(json).to eq(
            error: {
              message: {
                text: ["can't be blank"]
              },
              class: 'ModelValidationError',
              status: 422
            }
          )
        end
      end
    end
  end

  describe 'PUT #update' do
    let!(:post) { create(:post, user: current_user) }

    before :each do
      put "/api/v1/users/#{current_user.id}/posts/#{post.id}", { post: post_attributes },
        'HTTP_AUTHORIZATION' => current_user_credentials
    end

    context 'with valid attributes' do
      let!(:post_attributes) { { text: FFaker::Lorem.word } }

      it 'should respond with 200' do
        expect(response.status).to eq(200)
      end

      it 'should render post json' do
        expect(json).to eq(
          post: {
            id: post.id,
            text: post_attributes[:text],
            user: {
              id: current_user.id
            }
          }
        )
      end
    end

    context 'with invalid attributes' do
      context 'missing text' do
        let(:post_attributes) { { text: '' } }

        it 'should respond with 422' do
          expect(response.status).to eq(422)
        end

        it 'should render json errors' do
          expect(json).to eq(
            error: {
              message: {
                text: ["can't be blank"]
              },
              class: 'ModelValidationError',
              status: 422
            }
          )
        end
      end
    end
  end
end

