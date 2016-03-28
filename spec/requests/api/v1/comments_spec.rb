require 'rails_helper'

RSpec.describe 'API V1 Comments', type: :request do
  let!(:post_record) { create(:post) }

  describe 'GET #index' do
    let!(:comments_collection) { create_list(:comment, 2, post: post_record) }

    before :each do
      get "/api/v1/posts/#{post_record.id}/comments", {},
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
      let!(:comment) { create(:comment, post: post_record) }

      before :each do
        get "/api/v1/posts/#{post_record.id}/comments/#{comment.id}", {},
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
              id: post_record.id
            }
          }
        )
      end
    end

    context 'when record is not found' do
      before :each do
        get "/api/v1/posts/#{post_record.id}/comments/-1", {},
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

  describe 'POST #create' do
    let(:comment_attributes) { { text: FFaker::Lorem.word } }

    before :each do
      post "/api/v1/posts/#{post_record.id}/comments", { comment: comment_attributes },
        'HTTP_AUTHORIZATION' => current_user_credentials
    end

    context 'with valid attributes' do
      it 'should respond with 201' do
        expect(response.status).to eq(201)
      end

      it 'should render comment json' do
        expect(json).to eq(
          comment: {
            id: Comment.last.id,
            text: comment_attributes[:text],
            post: {
              id: post_record.id
            }
          }
        )
      end
    end

    context 'with invalid attributes' do
      context 'missing text' do
        let(:comment_attributes) { { text: '' } }

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
        let(:comment_attributes) { { text: 'lorem' * 140 } }

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
end
