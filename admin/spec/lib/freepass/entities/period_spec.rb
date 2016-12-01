require 'spec_helper'

RSpec.describe Period, type: :model do
  it { expect(described_class.ancestors).to include(Spyke::Base) }
end
