require 'spec_helper'

RSpec.describe Holidays do
  let(:request_headers) { headers(token, params) }

  let(:token)  { nil }
  let(:params) { { name: 'Independency day', happen_at: Date.parse('2016-07-04') } }

  describe 'GET /' do
    it 'should respond route' do
      get '/holidays', {}, request_headers
      expect(response.status).to eq 200
    end

    context 'with holidays' do
      before { create :holiday }

      it 'should respond all holidays' do
       get '/holidays', {}, request_headers
       expect(json_response.size).to eq 1
      end

      it 'should respond with paging headers' do
        get '/holidays', {}, request_headers

        expect(response.headers['X-Total-Pages']).to eq '1'
        expect(response.headers['X-Total-Count']).to eq '1'
        expect(response.headers['X-Per-Page']).to    eq '5'
      end

      context 'paginate' do
        let(:params) { { page: 2 } }

        it 'should respond with status 200' do
          get '/holidays', {}, request_headers
          expect(response.status).to eq 200
        end

        it 'should return empty holidays' do
          get '/holidays', {}, request_headers
          expect(json_response.size).to eq 0
        end
      end
    end
  end

  describe 'POST create' do
    it 'should create holiday' do
      post '/holidays', {}, request_headers
      expect(response.status).to eq 200
      expect(Holiday.count).to      eq 1
    end
  end

  describe 'GET /:id' do
    let(:holiday)  { create :holiday }

    it 'should return holiday' do
      get '/holidays/' + holiday.id, {}, request_headers
      expect(response.status).to     eq 200
      expect(json_response["id"]).to eq holiday.id
    end
  end

  describe 'PUT /:id' do
    let(:holiday) { create :holiday }
    let(:params)  { { name: '4th July' } }

    it 'should not return error' do
      put '/holidays/' + holiday.id, {}, request_headers
      expect(response.status).to     eq 200
    end

    it 'should update holiday attribute' do
      put '/holidays/' + holiday.id, {}, request_headers
      expect(holiday.reload.name).to eq '4th July'
    end
  end

  describe 'DELETE /:id' do
    let(:holiday) { create :holiday }

    it 'should not return error' do
      delete '/holidays/' + holiday.id, {}, request_headers
      expect(response.status).to eq 200
    end

    it 'should update holiday attribute' do
      delete '/holidays/' + holiday.id, {}, request_headers
      expect(Holiday.count).to eq 0
    end
  end
end
