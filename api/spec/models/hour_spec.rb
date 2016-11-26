require 'spec_helper'

RSpec.describe Hour, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :start_at }
  it { should validate_presence_of :end_at }

  it { should have_and_belong_to_many :periods }

  context '.days' do
    it { should respond_to :sunday }
    it { should respond_to :monday }
    it { should respond_to :tuesday }
    it { should respond_to :wednesday }
    it { should respond_to :thursday }
    it { should respond_to :friday }
    it { should respond_to :saturday }
  end

  describe '.search' do
    it 'should have method' do
      expect(Hour).to respond_to(:search)
    end
  end
end
