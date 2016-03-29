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
            comment_ids: posts_collection[1].comments.map { |comment| comment.id},
            links: {
              self: api_v1_user_post_path(user.id, posts_collection[1].id)
            },
            user: {
              id: user.id,
              username: user.username,
              email: user.email,
              first_name: user.first_name,
              last_name: user.last_name,
              post_ids: user.posts.map { |post| post.id },
              links: {
                self: api_v1_user_path(user.id)
              }
            }
          },
          {
            id: posts_collection[0].id,
            text: posts_collection[0].text,
            comment_ids: posts_collection[0].comments.map { |comment| comment.id},
            links: {
              self: api_v1_user_post_path(user.id, posts_collection[0].id)
            },
            user: {
              id: user.id,
              username: user.username,
              email: user.email,
              first_name: user.first_name,
              last_name: user.last_name,
              post_ids: user.posts.map { |post| post.id },
              links: {
                self: api_v1_user_path(user.id)
              }
            },
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
            comment_ids: post.comments.map { |comment| comment.id},
            links: {
              self: api_v1_user_post_path(user.id, post.id)
            },
            user: {
              id: user.id,
              username: user.username,
              email: user.email,
              first_name: user.first_name,
              last_name: user.last_name,
              post_ids: user.posts.map { |post| post.id },
              links: {
                self: api_v1_user_path(user.id)
              }
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
    let(:post_attributes) { { text: FFaker::Lorem.word } }

    before :each do
      post "/api/v1/users/#{user.id}/posts", { post: post_attributes },
        'HTTP_AUTHORIZATION' => current_user_credentials
    end

    context 'with valid attributes' do
      it 'should respond with 201' do
        expect(response.status).to eq(201)
      end

      it 'should render post json' do
        expect(json).to eq(
          post: {
            id: Post.last.id,
            text: post_attributes[:text],
            comment_ids: Post.last.comments.map { |comment| comment.id},
            links: {
              self: api_v1_user_post_path(user.id, Post.last.id)
            },
            user: {
              id: user.id,
              username: user.username,
              email: user.email,
              first_name: user.first_name,
              last_name: user.last_name,
              post_ids: user.posts.map { |post| post.id },
              links: {
                self: api_v1_user_path(user.id)
              }
            }
          }
        )
      end
    end

    context 'with invalid attributes' do
      let(:post_attributes) { { text: '' } }

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

      context 'text is too big' do
        let(:post_attributes) { { text: 'lorem' * 140 } }

        it 'should respond with 422' do
          expect(response.status).to eq(422)
        end

        it 'should render json errors' do
          expect(json).to eq(
            error: {
              message: {
                text: ['is too long (maximum is 140 characters)']
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
            comment_ids: post.comments.map { |comment| comment.id},
            links: {
              self: api_v1_user_post_path(current_user.id, post.id)
            },
            user: {
              id: current_user.id,
              username: current_user.username,
              email: current_user.email,
              first_name: current_user.first_name,
              last_name: current_user.last_name,
              post_ids: current_user.posts.map { |post| post.id },
              links: {
                self: api_v1_user_path(current_user.id)
              }
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

  describe 'DELETE #destroy' do
    let!(:post) { create(:post, user: current_user) }

    before :each do
      delete "/api/v1/users/#{current_user.id}/posts/#{post.id}", {},
        'HTTP_AUTHORIZATION' => current_user_credentials
    end

    it 'should respond with 204' do
      expect(response.status).to eq(204)
    end

    it 'should delete post record' do
      expect { raise post.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

