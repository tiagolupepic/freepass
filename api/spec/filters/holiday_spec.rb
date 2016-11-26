require 'spec_helper'

RSpec.describe HolidayFilterParams do
  let(:params) { { name: 'holiday name', happen_at: Date.today, admin: true } }

  subject { described_class.new(params) }

  it 'should return hash with valid params' do
    expect(subject.result[:name]).to  eq 'holiday name'
    expect(subject.result[:happen_at]).to eq Date.today
  end

  context 'with nil params' do
    let(:params) { { name: nil, happen_at: "", admin: true } }

    it 'should remove nil and invalid' do
      expect(subject.result.keys).to eq [:happen_at]
    end
  end
end
