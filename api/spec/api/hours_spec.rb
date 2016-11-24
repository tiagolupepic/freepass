require 'spec_helper'

RSpec.describe Hours do
  let(:request_headers) { headers(token, params) }

  let(:token)  { nil }
  let(:params) { { name: 'Interval', start_at: Time.now.strftime('%H:%M:%S'), end_at: Time.now.strftime('%H:%M:%S'), days: { monday: true } } }

  describe 'GET /' do
    it 'should respond route' do
      get '/hours', {}, request_headers
      expect(response.status).to eq 200
    end

    context 'with hours' do
      before { create :hour }

      it 'should respond all hours' do
       get '/hours', {}, request_headers
       expect(json_response.size).to eq 1
      end

      it 'should respond with paging headers' do
        get '/hours', {}, request_headers

        expect(response.headers['X-Total-Pages']).to eq '1'
        expect(response.headers['X-Total-Count']).to eq '1'
        expect(response.headers['X-Per-Page']).to    eq '5'
      end

      context 'paginate' do
        let(:params) { { page: 2 } }

        it 'should respond with status 200' do
          get '/hours', {}, request_headers
          expect(response.status).to eq 200
        end

        it 'should return empty hours' do
          get '/hours', {}, request_headers
          expect(json_response.size).to eq 0
        end
      end
    end
  end

  describe 'POST create' do
    it 'should create hour' do
      post '/hours', {}, request_headers
      expect(response.status).to eq 201
      expect(Hour.count).to      eq 1
    end

    context 'with invalid params' do
      let(:params) { { name: nil } }

      it 'should return error' do
        post '/hours', {}, request_headers
        expect(response.status).to eq 422
      end

      it 'should not create hour' do
        post '/hours', {}, request_headers
        expect(Hour.count).to eq 0
      end

      it 'should return errors' do
        post '/hours', {}, request_headers
        expect(json_response['errors']).to be_present
      end
    end
  end

  describe 'GET /:id' do
    let(:hour)  { create :hour }

    it 'should return hour' do
      get '/hours/' + hour.id, {}, request_headers
      expect(response.status).to     eq 200
      expect(json_response["id"]).to eq hour.id
    end
  end

  describe 'PUT /:id' do
    let(:hour) { create :hour }
    let(:params)  { { name: 'Name Changed' } }

    it 'should not return error' do
      put '/hours/' + hour.id, {}, request_headers
      expect(response.status).to     eq 200
    end

    it 'should update hour attribute' do
      put '/hours/' + hour.id, {}, request_headers
      expect(hour.reload.name).to eq 'Name Changed'
    end

    context 'with errors' do
      let(:params) { { name: "" } }

      it 'should return error' do
        put '/hours/' + hour.id, {}, request_headers
        expect(response.status).to     eq 422
      end

      it 'should return error details' do
        put '/hours/' + hour.id, {}, request_headers
        expect(json_response['errors']).to be_present
      end
    end
  end

  describe 'DELETE /:id' do
    let(:hour) { create :hour }

    it 'should not return error' do
      delete '/hours/' + hour.id, {}, request_headers
      expect(response.status).to eq 200
    end

    it 'should update hour attribute' do
      delete '/hours/' + hour.id, {}, request_headers
      expect(Hour.count).to eq 0
    end
  end
end
