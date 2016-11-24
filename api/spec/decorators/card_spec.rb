require 'spec_helper'

RSpec.describe CardDecorator do
  let(:model)  { create :card }
  let(:result) { subject.as_json }

  subject { described_class.new(model) }

  it { expect(described_class.ancestors).to include(Forwardable) }

  describe '#as_json' do
    it 'should parse json' do
      expect(result[:id]).to        eq model.id
      expect(result[:number]).to    eq model.number
      expect(result[:full_name]).to eq model.user.full_name
      expect(result[:email]).to     eq model.user.email
      expect(result[:user_id]).to   eq model.user_id
    end
  end

  context 'with errors' do
    let(:model)  { build :card, number: nil }

    it 'should parse errors' do
      expect(result[:errors]).to eq ({ number: [{ error: :blank}] })
    end

    it 'should parse json' do
      expect(result[:id]).to        eq model.id
    end
  end
end
