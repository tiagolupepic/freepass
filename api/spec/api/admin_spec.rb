require 'spec_helper'

RSpec.describe Admins do
  let(:request_headers) { headers(token, params) }
  let(:token)  { nil }
  let(:params) { { number: '123456', user_id: user.id } }

  describe 'POST /admins/auth' do
    let(:params) { { password: '123456' } }

    it 'should auth card' do
      post '/admins/auth', {}, request_headers
      expect(response.status).to eq 200
      expect(json_response['success']).to be_truthy
    end

    context 'without password' do
      let(:params) { { password: nil } }

      it 'should not auth admin' do
        post '/admins/auth', {}, request_headers
        expect(response.status).to eq 403
        expect(json_response['success']).to be_falsey
      end
    end
  end
end
