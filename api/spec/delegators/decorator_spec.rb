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

    context 'with User model' do
      let(:model) { create :user }

      it 'should decorate with decorator' do
        expect(result.class).to eq UserDecorator
      end
    end

    context 'with array of User model' do
      let(:model) { User.all }

      before do
        create :user
      end

      it 'should decorate with decorator' do
        expect(result.first.class).to eq UserDecorator
      end
    end
  end
end
