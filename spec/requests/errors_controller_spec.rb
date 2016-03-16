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

  context 'Not found resource' do
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
end
