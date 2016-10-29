require 'spec_helper'

RSpec.describe DecoratorDelegator do
  subject { described_class.new(model) }

  describe '#run' do
    let(:result) { subject.run }

    context 'with Hash' do
      let(:model) { { name: 'Freepass' } }

      it 'should decorate' do
        expect(result[:name]).to eq 'Freepass'
      end
    end

    context 'with Array' do
      let(:model) { ['Freepass'] }

      it 'should decorate' do
        expect(result).to eq ['Freepass']
      end
    end
  end
end
