require 'spec_helper'

RSpec.describe Holiday, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :happen_at }
end
