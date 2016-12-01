require 'spec_helper'

RSpec.describe User, type: :model do
  it { expect(described_class.ancestors).to include(Authenticable) }
  it { expect(described_class.ancestors).to include(PgSearch) }

  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:cpf) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password).on(:create) }

  it { should have_many :cards }
  it { should have_many :hours }
  it { should have_and_belong_to_many :periods }
  it { should have_and_belong_to_many :holidays }

  describe 'state machine' do
    let(:user) { create :user }

    it 'should start' do
      expect(user.requested?).to be_truthy
    end

    describe '#activate' do
      before do
        user.activate!
      end

      it 'should change state' do
        expect(user.activated?).to be_truthy
      end

      context 'when user is deactivated' do
        before do
          user.deactivate!
          user.activate!
        end

        it 'should activated' do
          expect(user.activated?).to be_truthy
        end
      end

      describe '#deactivate' do
        before do
          user.deactivate!
        end

        it 'should change state' do
          expect(user.deactivated?).to be_truthy
        end
      end
    end

    describe '#deactivate' do
      before do
        user.deactivate!
      end

      it 'should change state' do
        expect(user.deactivated?).to be_truthy
      end
    end
  end

  describe '.search' do
    it 'should have method' do
      expect(User).to respond_to(:search)
    end
  end
end
