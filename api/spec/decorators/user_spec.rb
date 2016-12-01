require 'spec_helper'

RSpec.describe UserDecorator do
  let(:model)  { create :user }
  let(:result) { subject.as_json }

  subject { described_class.new(model) }

  it { expect(described_class.ancestors).to include(Forwardable) }

  describe '#as_json' do
    it 'should parse json' do
      expect(result[:id]).to         eq model.id
      expect(result[:full_name]).to  eq model.full_name
      expect(result[:phone]).to      eq model.phone
      expect(result[:address]).to    eq model.address
      expect(result[:email]).to      eq model.email
      expect(result[:cpf]).to        eq model.cpf
      expect(result[:admin]).to      be_falsey
      expect(result[:state_name]).to eq 'Inativo'
      expect(result[:state]).to      eq 'requested'
      expect(result[:errors]).to     be_nil
    end

    context 'with errors' do
      let(:model)  { build :user, full_name: nil }

      it 'should parse errors' do
        expect(result[:errors]).to eq ({ full_name: [{ error: :blank}] })
      end

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
end
