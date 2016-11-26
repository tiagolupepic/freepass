require 'spec_helper'

RSpec.describe Card, type: :model do
  it { expect(described_class.ancestors).to include(PgSearch) }

  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:user) }
  it { should belong_to :user }

  describe '.search' do
    it 'should have method' do
      expect(Card).to respond_to(:search)
    end
  end
end
