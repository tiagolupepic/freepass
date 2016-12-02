require 'spec_helper'

RSpec.describe PeriodDecorator do
  let(:model)  { create :period }
  let(:result) { subject.as_json }

  subject { described_class.new(model) }

  it { expect(described_class.ancestors).to include(Forwardable) }

  describe '#as_json' do
    it 'should parse json' do
      expect(result[:id]).to       eq model.id
      expect(result[:name]).to     eq model.name
      expect(result[:start_at]).to eq model.start_at.strftime('%d/%m/%Y')
      expect(result[:end_at]).to   eq model.end_at.strftime('%d/%m/%Y')
    end

    context 'with errors' do
      let(:model) { build :period, name: nil }

      it 'should parse errors' do
        expect(result[:errors]).to eq ({ name: [{ error: :blank}] })
      end

      it 'should parse json' do
        expect(result[:id]).to eq model.id
      end
    end

    context 'with hours' do
      let!(:hour) { create :hour, periods: [model] }

      it 'should parse hour_ids' do
        expect(result[:hour_ids]).to   eq [hour.id.to_s]
        expect(result[:hour_names]).to eq 'Interval'
        expect(result[:hours]).to      eq([['Interval', hour.id.to_s]])
      end
    end
  end
end
