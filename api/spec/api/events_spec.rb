require 'spec_helper'

RSpec.describe Api::Events do
  let(:request_headers) { headers(token, params) }

  let(:token)  { nil }
  let(:params) { {  } }

  describe 'GET /' do
    it 'should respond route' do
      get '/events', {}, request_headers
      expect(response.status).to eq 200
    end

    context 'with events' do
      before { create :event }

      it 'should respond all events' do
       get '/events', {}, request_headers
       expect(json_response.size).to eq 1
      end
    end
  end
end
