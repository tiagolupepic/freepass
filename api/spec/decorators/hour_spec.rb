require 'spec_helper'

RSpec.describe HourDecorator do
  let(:model)  { create :hour }
  let(:result) { subject.as_json }

  subject { described_class.new(model) }

  it { expect(described_class.ancestors).to include(Forwardable) }

  describe '#as_json' do
    it 'should parse json' do
      expect(result[:id]).to       eq model.id
      expect(result[:name]).to     eq model.name
      expect(result[:start_at]).to eq model.start_at.strftime('%H:%M')
      expect(result[:end_at]).to   eq model.end_at.strftime('%H:%M')
      expect(result[:days]).to     eq []
    end

    context 'with errors' do
      let(:model) { build :hour, name: nil, days: nil }

      it 'should parse errors' do
        expect(result[:errors]).to eq ({ name: [{ error: :blank}] })
      end

      it 'should parse json' do
        expect(result[:id]).to eq model.id
      end
    end
  end
end
