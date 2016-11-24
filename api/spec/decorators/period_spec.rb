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
  end
end
