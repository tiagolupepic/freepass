require 'spec_helper'

RSpec.describe User, type: :model do
  it { expect(described_class.ancestors).to include(Authenticable) }

  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:cpf) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password).on(:create) }

  it { should have_many :cards }
  it { should have_and_belong_to_many :periods }
  it { should have_and_belong_to_many :holidays }
end
