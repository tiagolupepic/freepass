require 'spec_helper'

RSpec.describe HourFilterParams do
  let(:params) { { name: 'Morning', start_at: Time.parse('Nov, 26 2016'), admin: true } }

  subject { described_class.new(params) }

  it 'should return hash with valid params' do
    expect(subject.result[:name]).to     eq 'Morning'
    expect(subject.result[:start_at]).to eq Time.parse('Nov, 26 2016')
  end

  context 'with nil params' do
    let(:params) { { name: nil, start_at: "", admin: true } }

    it 'should remove nil and invalid' do
      expect(subject.result.keys).to eq [:start_at]
    end
  end

  context 'with days params' do
    let(:params) { { days: ["monday", "sunday"] } }

    it 'should parse' do
      expect(subject.result[:days]).to eq ({ monday: true, sunday: true })
    end
  end
end
