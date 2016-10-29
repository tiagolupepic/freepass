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
    end
  end

  describe 'POST create' do
    it 'should create card' do
      post '/cards', {}, request_headers
      expect(response.status).to eq 200
      expect(Card.count).to      eq 1
    end
  end

  describe 'GET /:id' do
    let(:card)  { create :card }

    it 'should return card' do
      get '/cards/' + card.id, {}, request_headers
      expect(response.status).to     eq 200
      expect(json_response["id"]).to eq card.id
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
end
