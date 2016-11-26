require 'spec_helper'

RSpec.describe Cards do
  let(:request_headers) { headers(token, params) }

  let(:token)  { nil }
  let(:params) { { number: '123456', user_id: user.id } }
  let(:user)   { create :user }

  describe 'GET /' do
    it 'should respond route' do
      get '/cards', {}, request_headers
      expect(response.status).to eq 200
    end

    context 'with cards' do
      before { create :card }

      it 'should respond all cards' do
       get '/cards', {}, request_headers
       expect(json_response.size).to eq 1
      end

      it 'should respond with paging headers' do
        get '/cards', {}, request_headers

        expect(response.headers['X-Total-Pages']).to eq '1'
        expect(response.headers['X-Total-Count']).to eq '1'
        expect(response.headers['X-Per-Page']).to    eq '5'
      end

      context 'paginate' do
        let(:params) { { page: 2 } }

        it 'should respond with status 200' do
          get '/cards', {}, request_headers
          expect(response.status).to eq 200
        end

        it 'should return empty cards' do
          get '/cards', {}, request_headers
          expect(json_response.size).to eq 0
        end
      end
    end
  end

  describe 'POST create' do
    it 'should create card' do
      post '/cards', {}, request_headers
      expect(response.status).to eq 201
      expect(Card.count).to      eq 1
    end

    context 'with invalid params' do
      let(:params) { { number: nil } }

      it 'should return error' do
        post '/cards', {}, request_headers
        expect(response.status).to eq 422
      end

      it 'should not create card' do
        post '/cards', {}, request_headers
        expect(Card.count).to eq 0
      end

      it 'should return errors' do
        post '/cards', {}, request_headers
        expect(json_response['errors']).to be_present
      end
    end
  end

  describe 'GET /:id' do
    let(:card)  { create :card }

    it 'should return card' do
      get '/cards/' + card.id, {}, request_headers
      expect(response.status).to     eq 200
      expect(json_response["id"]).to eq card.id
    end

    context 'when card doesnt exist' do
      it 'should return card' do
        get '/cards/1234', {}, request_headers
        expect(response.status).to     eq 404
        expect(json_response["error"]).to eq 'Card not found.'
      end
    end
  end

  describe 'PUT /:id' do
    let(:card)   { create :card }
    let(:params) { { number: 'Another number' } }

    it 'should not return error' do
      put '/cards/' + card.id, {}, request_headers
      expect(response.status).to     eq 200
    end

    it 'should update card attribute' do
      put '/cards/' + card.id, {}, request_headers
      expect(card.reload.number).to eq 'Another number'
    end

    context 'with errors' do
      let(:params) { { number: "" } }

      it 'should return error' do
        put '/cards/' + card.id, {}, request_headers
        expect(response.status).to eq 422
      end

      it 'should return error details' do
        put '/cards/' + card.id, {}, request_headers
        expect(json_response['errors']).to be_present
      end
    end
  end

  describe 'DELETE /:id' do
    let(:card)   { create :card }
    let(:params) { { number: 'Another number' } }

    it 'should not return error' do
      delete '/cards/' + card.id, {}, request_headers
      expect(response.status).to eq 200
    end

    it 'should update card attribute' do
      delete '/cards/' + card.id, {}, request_headers
      expect(Card.count).to eq 0
    end
  end

  describe 'POST /cards/auth' do
    let(:params)  { { number: '123456' } }
    let!(:card)   { create :card, number: params[:number], user: user }
    let(:user)    { build :user }

    it 'should auth card' do
      post '/cards/auth', {}, request_headers
      expect(response.status).to           eq 200
      expect(json_response['success']).to  be_truthy
      expect(json_response['user']).to_not be_empty
    end

    context 'without number' do
      let!(:card)  { create :card, number: 'other number', user: user }
      let(:params) { { number: nil } }

      it 'should auth card' do
        post '/cards/auth', {}, request_headers
        expect(response.status).to          eq 403
        expect(json_response['success']).to be_falsey
        expect(json_response['user']).to    be_nil
      end
    end
  end
end
