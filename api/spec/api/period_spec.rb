require 'spec_helper'

RSpec.describe Periods do
  let(:request_headers) { headers(token, params) }

  let(:token)  { nil }
  let(:params) { { name: 'Interval', start_at: Time.now.utc.to_s(:iso8601), end_at: Time.now.utc.to_s(:iso8601) } }

  describe 'GET /' do
    it 'should respond route' do
      get '/periods', {}, request_headers
      expect(response.status).to eq 200
    end

    context 'with periods' do
      before { create :period }

      it 'should respond all periods' do
       get '/periods', {}, request_headers
       expect(json_response.size).to eq 1
      end
    end
  end

  describe 'POST create' do
    it 'should create period' do
      post '/periods', {}, request_headers
      expect(response.status).to eq 200
      expect(Period.count).to      eq 1
    end
  end

  describe 'GET /:id' do
    let(:period)  { create :period }

    it 'should return period' do
      get '/periods/' + period.id, {}, request_headers
      expect(response.status).to     eq 200
      expect(json_response["id"]).to eq period.id
    end
  end

  describe 'PUT /:id' do
    let(:period) { create :period }
    let(:params)  { { name: 'Name Changed' } }

    it 'should not return error' do
      put '/periods/' + period.id, {}, request_headers
      expect(response.status).to     eq 200
    end

    it 'should update period attribute' do
      put '/periods/' + period.id, {}, request_headers
      expect(period.reload.name).to eq 'Name Changed'
    end
  end

  describe 'DELETE /:id' do
    let(:period) { create :period }

    it 'should not return error' do
      delete '/periods/' + period.id, {}, request_headers
      expect(response.status).to eq 200
    end

    it 'should update period attribute' do
      delete '/periods/' + period.id, {}, request_headers
      expect(Period.count).to eq 0
    end
  end
end
