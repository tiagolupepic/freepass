require 'spec_helper'

RSpec.describe Admins do
  let(:request_headers) { headers(token, params) }
  let(:token)  { nil }
  let(:params) { {} }
  let!(:user)  { create :user, role: 'admin', password: '123456' }

  describe 'POST /admins/auth' do
    let(:password) { '123456' }
    let(:params) { { password: password } }

    it 'should auth card' do
      post '/admins/auth', {}, request_headers
      expect(response.status).to eq 200
      expect(json_response['success']).to  be_truthy
      expect(json_response['user']).to_not be_empty
    end

    context 'without password' do
      let(:password) { nil }

      it 'should not auth admin' do
        post '/admins/auth', {}, request_headers
        expect(response.status).to eq 403
        expect(json_response['success']).to be_falsey
        expect(json_response['user']).to    be_nil
      end
    end
  end
end
