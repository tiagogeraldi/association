FactoryBot.define do
  factory :person do
    name { Faker::Name.name }
    phone_number { Faker::PhoneNumber.phone_number }
    national_id { CPF.generate }
    active { [true, false].sample }
    user
  end
end
