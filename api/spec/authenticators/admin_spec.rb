require 'spec_helper'

RSpec.describe AdminAuthenticator do
  let(:password) { nil }
  let(:role)     { :user }

  subject { described_class.new(password) }

  it 'should not be valid' do
    expect(subject).to_not be_valid
  end

  context 'with valid user' do
    let(:password) { '123456' }
    let!(:user)    { create :user, password: password, role: role }

    it 'should be invalid' do
      expect(subject).to_not be_valid
    end

    context 'with role admin' do
      let(:role) { :admin }

      it 'should be valid' do
        expect(subject).to be_valid
      end

      describe '#object' do
        it 'should receive object' do
          expect(subject.object).to eq user
        end
      end
    end
  end

  describe '#object' do
    it 'should return nil' do
      expect(subject.object).to be_nil
    end
  end
end
