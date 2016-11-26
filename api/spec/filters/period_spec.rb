require 'spec_helper'

RSpec.describe PeriodFilterParams do
  let(:params) { { name: 'Morning', start_at: Time.parse('Nov, 6 2016'), end_at: Time.parse('Nov, 26 2016'), hour_ids: [1, 2], admin: true } }

  subject { described_class.new(params) }

  it 'should return hash with valid params' do
    expect(subject.result[:name]).to     eq 'Morning'
    expect(subject.result[:start_at]).to eq Time.parse('Nov, 6 2016')
    expect(subject.result[:end_at]).to   eq Time.parse('Nov, 26 2016')
    expect(subject.result[:hour_ids]).to eq [1, 2]
  end

  context 'with nil params' do
    let(:params) { { name: nil, start_at: "", admin: true } }

    it 'should remove nil and invalid' do
      expect(subject.result.keys).to eq [:start_at]
    end
  end
end
