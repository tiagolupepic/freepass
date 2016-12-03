require 'spec_helper'

RSpec.describe Api::Users do
  let(:request_headers) { headers(token, params) }

  let(:token)  { nil }
  let(:params) { { full_name: 'Freepass user', password: '123456', email: 'user@freepass', cpf: CPF.generate, admin: true } }

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
        expect(response.headers['X-Per-Page']).to    eq '5'
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

  describe 'GET /?q=' do
    it 'should respond route' do
      get '/users?q=user', {}, request_headers
      expect(response.status).to eq 200
    end

    context 'with users' do
      before do
        create :user, full_name: 'John Doe'
        create :user, full_name: 'Another User'
      end

      it 'should respond all users' do
       get '/users?q=john', {}, request_headers
       expect(json_response.size).to eq 1
      end

      it 'should respond with paging headers' do
        get '/users?q=john', {}, request_headers

        expect(response.headers['X-Total-Pages']).to eq '1'
        expect(response.headers['X-Total-Count']).to eq '1'
        expect(response.headers['X-Per-Page']).to    eq '5'
      end

      context 'paginate' do
        let(:params) { { page: 2 } }

        it 'should respond with status 200' do
          get '/users?q=john', {}, request_headers
          expect(response.status).to eq 200
        end

        it 'should return empty users' do
          get '/users?q=john', {}, request_headers
          expect(json_response.size).to eq 0
        end
      end
    end
  end

  describe 'POST create' do
    it 'should create user' do
      post '/users', {}, request_headers
      expect(response.status).to eq 201
      expect(User.count).to      eq 1
    end

    context 'with invalid params' do
      let(:params) { { full_name: nil } }

      it 'should return error' do
        post '/users', {}, request_headers
        expect(response.status).to eq 422
      end

      it 'should not create user' do
        post '/users', {}, request_headers
        expect(User.count).to eq 0
      end

      it 'should return errors' do
        post '/users', {}, request_headers
        expect(json_response['errors']).to be_present
      end
    end
  end

  describe 'GET /:id' do
    let(:user)  { create :user }

    it 'should return user' do
      get '/users/' + user.id, {}, request_headers
      expect(response.status).to     eq 200
      expect(json_response["id"]).to eq user.id
    end

    context 'when user doesnt exist' do
      it 'should return error' do
        get '/users/1234', {}, request_headers
        expect(response.status).to     eq 404
        expect(json_response["error"]).to eq 'User not found.'
      end
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

    context 'with errors' do
      let(:params) { { full_name: "" } }

      it 'should return error' do
        put '/users/' + user.id, {}, request_headers
        expect(response.status).to     eq 422
      end

      it 'should return error details' do
        put '/users/' + user.id, {}, request_headers
        expect(json_response['errors']).to be_present
      end
    end
  end

  describe 'PUT /:id/deactivated' do
    let(:user)   { create :user }
    let(:params) { { } }

    it 'should not return error' do
      put '/users/' + user.id + '/deactivated', {}, request_headers
      expect(response.status).to eq 200
    end

    it 'should deactivated user' do
      put '/users/' + user.id + '/deactivated', {}, request_headers
      expect(user.reload).to be_deactivated
    end
  end

  describe 'PUT /:id/activate' do
    let(:user)   { create :user }
    let(:params) { { } }

    it 'should not return error' do
      put '/users/' + user.id + '/activated', {}, request_headers
      expect(response.status).to eq 200
    end

    it 'should activate user' do
      put '/users/' + user.id + '/activated', {}, request_headers
      expect(user.reload).to be_activated
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

  describe 'POST /users/auth' do
    let!(:user)    { create :user, role: 'user', password: '123456', state: :activated }
    let(:password) { '123456' }
    let(:params) { { password: password, cpf: user.cpf } }

    it 'should auth card' do
      post '/users/auth', {}, request_headers
      expect(response.status).to eq 200
      expect(json_response['success']).to  be_truthy
      expect(json_response['user']).to_not be_empty
    end

    context 'without password' do
      let(:password) { nil }

      it 'should not auth admin' do
        post '/users/auth', {}, request_headers
        expect(response.status).to eq 403
        expect(json_response['success']).to be_falsey
        expect(json_response['user']).to    be_nil
      end
    end
  end
end
