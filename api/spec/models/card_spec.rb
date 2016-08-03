require 'spec_helper'

RSpec.describe Card, type: :model do
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:user) }
  it { should belong_to :user }
end
