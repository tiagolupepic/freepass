require 'spec_helper'

RSpec.describe Holiday, type: :model do
  it { expect(described_class.ancestors).to include(Spyke::Base) }
end
