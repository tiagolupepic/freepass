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
    end
  end
end
