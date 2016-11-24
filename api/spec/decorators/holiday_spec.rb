require 'spec_helper'

RSpec.describe HolidayDecorator do
  let(:model)  { create :holiday }
  let(:result) { subject.as_json }

  subject { described_class.new(model) }

  it { expect(described_class.ancestors).to include(Forwardable) }

  describe '#as_json' do
    it 'should parse json' do
      expect(result[:id]).to         eq model.id
      expect(result[:name]).to       eq model.name
      expect(result[:happen_at]).to  eq '04/07/2016'
    end

    context 'with errors' do
      let(:model)  { build :holiday, name: nil }

      it 'should parse errors' do
        expect(result[:errors]).to eq ({ name: [{ error: :blank}] })
      end

      it 'should parse json' do
        expect(result[:id]).to eq model.id
      end
    end
  end
end
