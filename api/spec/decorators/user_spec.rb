require 'spec_helper'

RSpec.describe UserDecorator do
  let(:model)  { create :user }
  let(:result) { subject.as_json }

  subject { described_class.new(model) }

  it { expect(described_class.ancestors).to include(Forwardable) }

  describe '#as_json' do
    it 'should parse json' do
      expect(result[:id]).to        eq model.id
      expect(result[:full_name]).to eq model.full_name
      expect(result[:phone]).to     eq model.phone
      expect(result[:address]).to   eq model.address
      expect(result[:email]).to     eq model.email
      expect(result[:cpf]).to       eq model.cpf
      expect(result[:admin]).to     be_falsey
    end
  end
end
