require 'spec_helper'

RSpec.describe UserFilterParams do
  let(:params) { { full_name: 'freepass name', phone: '12345678', admin: true } }

  subject { described_class.new(params) }

  it 'should return hash with valid params' do
    expect(subject.result[:full_name]).to eq 'freepass name'
    expect(subject.result[:admin]).to     be_nil
  end

  context 'with nil params' do
    let(:params) { { full_name: nil, phone: "", admin: true } }

    it 'should remove nil and invalid' do
      expect(subject.result.keys).to eq [:phone]
    end
  end
end
