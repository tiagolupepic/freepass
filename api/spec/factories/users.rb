FactoryGirl.define do
  factory :user do
    full_name 'Freepass'
    email     { "#{Faker::Name.name}#{Faker::Internet.free_email}" }
    password  '12345678'
    cpf       { CPF.generate(false) }
  end
end
