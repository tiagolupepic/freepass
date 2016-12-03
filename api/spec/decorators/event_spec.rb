require 'spec_helper'

describe EventDecorator do
  let(:name)   { 'card.auth.success.true' }
  let(:model)  { create :event, name: name, created_at: Time.parse('Dec 2, 2016 11:00') }
  let(:result) { subject.as_json }

  subject { described_class.new(model) }

  it { expect(described_class.ancestors).to include(Forwardable) }

  describe '#as_json' do

    context 'card' do
      it 'should parse json' do
        expect(result[:id]).to        eq model.id
        expect(result[:name]).to      eq 'Cartão / RFID'
        expect(result[:status]).to    eq 'Autorizado'
        expect(result[:event_at]).to  eq '02/12/2016 11:00'
        expect(result[:user_name]).to eq model.user.full_name
      end

      context 'when success false' do
        let(:name) { 'card.auth.success.false' }

        it 'should parse json' do
          expect(result[:status]).to eq 'Não Autorizado'
        end
      end
    end

    context 'admin' do
      let(:name) { 'admin.auth.success.true' }

      it 'should parse json' do
        expect(result[:id]).to        eq model.id
        expect(result[:name]).to      eq 'Administrador'
        expect(result[:status]).to    eq 'Autorizado'
        expect(result[:event_at]).to  eq '02/12/2016 11:00'
        expect(result[:user_name]).to eq model.user.full_name
      end

      context 'when success false' do
        let(:name) { 'admin.auth.success.false' }

        it 'should parse json' do
          expect(result[:status]).to eq 'Não Autorizado'
        end
      end
    end

    context 'user' do
      let(:name) { 'user.auth.success.true' }

      it 'should parse json' do
        expect(result[:id]).to        eq model.id
        expect(result[:name]).to      eq 'Usuário'
        expect(result[:status]).to    eq 'Autorizado'
        expect(result[:event_at]).to  eq '02/12/2016 11:00'
        expect(result[:user_name]).to eq model.user.full_name
      end

      context 'when success false' do
        let(:name) { 'admin.auth.success.false' }

        it 'should parse json' do
          expect(result[:status]).to eq 'Não Autorizado'
        end
      end
    end
  end
end
