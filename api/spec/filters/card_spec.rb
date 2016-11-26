require 'spec_helper'

RSpec.describe CardFilterParams do
  let(:params) { { number: 'card number', user_id: '1', admin: true } }

  subject { described_class.new(params) }

  it 'should return hash with valid params' do
    expect(subject.result[:number]).to  eq 'card number'
    expect(subject.result[:user_id]).to eq '1'
  end

  context 'with nil params' do
    let(:params) { { number: nil, user_id: "", admin: true } }

    it 'should remove nil and invalid' do
      expect(subject.result.keys).to eq [:user_id]
    end
  end
end
