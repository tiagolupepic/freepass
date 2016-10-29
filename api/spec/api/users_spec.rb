require 'spec_helper'

RSpec.describe Users do
  let(:request_headers) { headers(token, params) }

  let(:token)  { nil }
  let(:params) { { full_name: 'Freepass user', password: '123456', email: 'user@freepass' } }

  describe 'GET /' do
    it 'should respond route' do
      get '/users', {}, request_headers
      expect(response.status).to eq 200
    end

    context 'with users' do
      before { create :user }

      it 'should respond all users' do
       get '/users', {}, request_headers
       expect(json_response.size).to eq 1
      end

      it 'should respond with paging headers' do
        get '/users', {}, request_headers

        expect(response.headers['X-Total-Pages']).to eq '1'
        expect(response.headers['X-Total-Count']).to eq '1'
        expect(response.headers['X-Per-Page']).to    eq 5
      end

      context 'paginate' do
        let(:params) { { page: 2 } }

        it 'should respond with status 200' do
          get '/users', {}, request_headers
          expect(response.status).to eq 200
        end

        it 'should return empty users' do
          get '/users', {}, request_headers
          expect(json_response.size).to eq 0
        end
      end
    end
  end

  describe 'POST create' do
    it 'should create user' do
      post '/users', {}, request_headers
      expect(response.status).to eq 200
      expect(User.count).to      eq 1
    end
  end

  describe 'GET /:id' do
    let(:user)  { create :user }

    it 'should return user' do
      get '/users/' + user.id, {}, request_headers
      expect(response.status).to     eq 200
      expect(json_response["id"]).to eq user.id
    end
  end

  describe 'PUT /:id' do
    let(:user)   { create :user }
    let(:params) { { full_name: 'Another name' } }

    it 'should not return error' do
      put '/users/' + user.id, {}, request_headers
      expect(response.status).to     eq 200
    end

    it 'should update user attribute' do
      put '/users/' + user.id, {}, request_headers
      expect(user.reload.full_name).to eq 'Another name'
    end
  end

  describe 'DELETE /:id' do
    let(:user)   { create :user }
    let(:params) { { full_name: 'Another name' } }

    it 'should not return error' do
      delete '/users/' + user.id, {}, request_headers
      expect(response.status).to eq 200
    end

    it 'should update user attribute' do
      delete '/users/' + user.id, {}, request_headers
      expect(User.count).to eq 0
    end
  end
end
