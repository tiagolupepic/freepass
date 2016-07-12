require 'spec_helper'

RSpec.describe Holidays do
  let(:request_headers) { headers(token, params) }

  let(:token)  { nil }
  let(:params) { { name: 'Independency day', happen_at: Date.parse('2016-07-04') } }

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
