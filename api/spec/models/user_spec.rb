require 'spec_helper'

RSpec.describe User, type: :model do
  it { expect(described_class.ancestors).to include(Authenticable) }

  it { should validate_presence_of(:full_name).on(:create) }
  it { should validate_presence_of(:email).on(:create) }
  it { should validate_presence_of(:password).on(:create) }
end
