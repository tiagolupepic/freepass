require 'spec_helper'

RSpec.describe Users do
  let(:request_headers) { headers(token, params) }

  let(:token)  { nil }
  let(:params) { { full_name: 'Freepass user', password: '123456', email: 'user@freepass' } }

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
