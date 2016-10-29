require 'spec_helper'

RSpec.describe Period, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :start_at }
  it { should validate_presence_of :end_at }

  it { should have_and_belong_to_many :hours }
end