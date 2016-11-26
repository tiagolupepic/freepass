require 'spec_helper'

RSpec.describe Holiday, type: :model do
  it { expect(described_class.ancestors).to include(PgSearch) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :happen_at }

  it { should have_and_belong_to_many :users }

  describe '.search' do
    it 'should have method' do
      expect(Holiday).to respond_to(:search)
    end
  end
end
