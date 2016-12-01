require 'spec_helper'

RSpec.describe Hour, type: :model do
  it { expect(described_class.ancestors).to include(Spyke::Base) }
end
