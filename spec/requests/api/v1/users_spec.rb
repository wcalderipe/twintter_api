require 'rails_helper'

RSpec.describe 'API V1 Users', type: :request do
  describe 'GET #index' do

  end

  describe 'GET #show' do
    context 'when record is found' do
      let!(:user) { create(:user) }

      before :each do
        get "/api/v1/users/#{user.id}"
      end

      it 'should respond with 200' do
        expect(response.status).to eq(200)
      end

      it 'should render user json' do
        expect(json).to eq(
          user: {
            id: user.id,
            username: user.username,
            email: user.email,
            first_name: user.first_name,
            last_name: user.last_name
          }
        )
      end
    end

    context 'when record is not found' do
      before :each do
        get '/api/v1/users/-1'
      end

      it 'should respond with 404' do
        expect(response.status).to eq(404)
      end

      it 'should render json errors' do
        expect(json).to eq(
          error: {
            message: "Couldn't find User with 'id'=-1",
            class: 'ActiveRecord::RecordNotFound',
            status: 404
          }
        )
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let!(:user_attributes) { attributes_for(:user) }

      before :each do
        post '/api/v1/users', { user: user_attributes }
      end

      it 'should respond with 201' do
        expect(response.status).to eq(201)
      end

      it 'should render user json' do
        expect(json).to eq(
          user: {
            id: User.last.id,
            username: user_attributes[:username],
            email: user_attributes[:email],
            first_name: user_attributes[:first_name],
            last_name: user_attributes[:last_name]
          }
        )
      end
    end

    context 'with invalid attributes' do
      let(:user_attributes) { attributes_for(:user) }

      before :each do
        post '/api/v1/users', { user: user_attributes }
      end

      context 'wrong password confirmation' do
        let(:user_attributes) { attributes_for(:user, password_confirmation: '123') }

        it 'should respond with 422' do
          expect(response.status).to eq(422)
        end

        it 'should render json errors' do
          expect(json).to eq(
            error: {
              message: {
                password_confirmation: ["doesn't match Password"]
              },
              class: 'ModelValidationError',
              status: 422
            }
          )
        end
      end

      context 'missing email' do
        let(:user_attributes) { attributes_for(:user, email: nil) }

        it 'should respond with 422' do
          expect(response.status).to eq(422)
        end

        it 'should render json errors' do
          expect(json).to eq(
            error: {
              message: {
                email: ["can't be blank"]
              },
              class: 'ModelValidationError',
              status: 422
            }
          )
        end
      end

      context 'missing username' do
        let(:user_attributes) { attributes_for(:user, username: nil) }

        it 'should respond with 422' do
          expect(response.status).to eq(422)
        end

        it 'should render json errors' do
          expect(json).to eq(
            error: {
              message: {
                username: ["can't be blank"]
              },
              class: 'ModelValidationError',
              status: 422
            }
          )
        end
      end

      context 'missing first_name' do
        let(:user_attributes) { attributes_for(:user, first_name: nil) }

        it 'should respond with 422' do
          expect(response.status).to eq(422)
        end

        it 'should render json errors' do
          expect(json).to eq(
            error: {
              message: {
                first_name: ["can't be blank"]
              },
              class: 'ModelValidationError',
              status: 422
            }
          )
        end
      end

      context 'missing last_name' do
        let(:user_attributes) { attributes_for(:user, last_name: nil) }

        it 'should respond with 422' do
          expect(response.status).to eq(422)
        end

        it 'should render json errors' do
          expect(json).to eq(
            error: {
              message: {
                last_name: ["can't be blank"]
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
