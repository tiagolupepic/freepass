require 'spec_helper'

RSpec.describe Api::Periods do
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

      it 'should respond with paging headers' do
        get '/periods', {}, request_headers

        expect(response.headers['X-Total-Pages']).to eq '1'
        expect(response.headers['X-Total-Count']).to eq '1'
        expect(response.headers['X-Per-Page']).to    eq '5'
      end

      context 'paginate' do
        let(:params) { { page: 2 } }

        it 'should respond with status 200' do
          get '/periods', {}, request_headers
          expect(response.status).to eq 200
        end

        it 'should return empty periods' do
          get '/periods', {}, request_headers
          expect(json_response.size).to eq 0
        end
      end
    end
  end

  describe 'GET /q?=name' do
    it 'should respond route' do
      get '/periods?q=name', {}, request_headers
      expect(response.status).to eq 200
    end

    context 'with periods' do
      before do
        create :period, name: 'name'
        create :period, name: 'example'
      end

      it 'should respond all periods' do
       get '/periods?q=name', {}, request_headers
       expect(json_response.size).to eq 1
      end

      it 'should respond with paging headers' do
        get '/periods?q=name', {}, request_headers

        expect(response.headers['X-Total-Pages']).to eq '1'
        expect(response.headers['X-Total-Count']).to eq '1'
        expect(response.headers['X-Per-Page']).to    eq '5'
      end

      context 'paginate' do
        let(:params) { { page: 2 } }

        it 'should respond with status 200' do
          get '/periods?q=name', {}, request_headers
          expect(response.status).to eq 200
        end

        it 'should return empty periods' do
          get '/periods?q=name', {}, request_headers
          expect(json_response.size).to eq 0
        end
      end
    end
  end

  describe 'POST create' do
    it 'should create period' do
      post '/periods', {}, request_headers
      expect(response.status).to eq 201
      expect(Period.count).to eq 1
    end

    context 'with invalid params' do
      let(:params) { { name: nil } }

      it 'should return error' do
        post '/periods', {}, request_headers
        expect(response.status).to eq 422
      end

      it 'should not create period' do
        post '/periods', {}, request_headers
        expect(Period.count).to eq 0
      end

      it 'should return errors' do
        post '/periods', {}, request_headers
        expect(json_response['errors']).to be_present
      end
    end
  end

  describe 'GET /:id' do
    let(:period)  { create :period }

    it 'should return period' do
      get '/periods/' + period.id, {}, request_headers
      expect(response.status).to     eq 200
      expect(json_response["id"]).to eq period.id
    end

    context 'when period doesnt exist' do
      it 'should return error' do
        get '/periods/1234', {}, request_headers
        expect(response.status).to     eq 404
        expect(json_response["error"]).to eq 'Period not found.'
      end
    end
  end

  describe 'PUT /:id' do
    let(:period) { create :period }
    let(:params)  { { name: 'Name Changed' } }

    it 'should not return error' do
      put '/periods/' + period.id, {}, request_headers
      expect(response.status).to eq 200
    end

    it 'should update period attribute' do
      put '/periods/' + period.id, {}, request_headers
      expect(period.reload.name).to eq 'Name Changed'
    end

    context 'with errors' do
      let(:params) { { name: "" } }

      it 'should return error' do
        put '/periods/' + period.id, {}, request_headers
        expect(response.status).to eq 422
      end

      it 'should return error details' do
        put '/periods/' + period.id, {}, request_headers
        expect(json_response['errors']).to be_present
      end
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
