FactoryBot.define do
  factory :debt do
    person
    amount { 99 }
    observation { 'any-text' }
  end
end
