require 'rails_helper'

describe 'API Errors', type: :request do
  describe 'GET /' do
    before :each do
      get '/'
    end

    it 'should respond with 404' do
      expect(response.status).to eq(404)
    end
  end

  context 'not found resource' do
    describe 'GET /lorem' do
      before :each do
        get '/lorem'
      end

      it 'should respond with 404' do
        expect(response.status).to eq(404)
      end
    end

    describe 'POST /lorem' do
      before :each do
        post '/lorem'
      end

      it 'should respond with 404' do
        expect(response.status).to eq(404)
      end
    end

    describe 'PUT /lorem' do
      before :each do
        put '/lorem'
      end

      it 'should respond with 404' do
        expect(response.status).to eq(404)
      end
    end

    describe 'PATCH /lorem' do
      before :each do
        patch '/lorem'
      end

      it 'should respond with 404' do
        expect(response.status).to eq(404)
      end
    end

    describe 'DELETE /lorem' do
      before :each do
        delete '/lorem'
      end

      it 'should respond with 404' do
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'not authorized' do
    let!(:guest) { create(:user, role: :guest) }
    let(:post_attributes) { { text: FFaker::Lorem.word } }

    before :each do 
      post "/api/v1/users/#{guest.id}/posts", { post: post_attributes },
        'HTTP_AUTHORIZATION' => encode_credentials(guest)
    end

    it 'should respond with 403' do
      expect(response.status).to eq(403)
    end

    it 'should render error json' do
      expect(json).to eq(
        error: {
          message: 'Not authorized',
          class: 'Pundit::NotAuthorizedError',
          status: 403
        }
      )
    end
  end

  describe 'not authenticated' do
    let!(:guest) do
      create(:user, role: :guest, password: '123123123', 
        password_confirmation: '123123123')
    end

    before :each do
      get '/api/v1/users', {}, 'HTTP_AUTHORIZATION' => encode_credentials(guest)
    end

    it 'should respond with 401' do
      expect(response.status).to eq(401)
    end

    it 'should render error json' do
      expect(json).to eq(
        error: {
          message: ['Not authenticated'],
          status: 401
        }
      )
    end
  end
end
