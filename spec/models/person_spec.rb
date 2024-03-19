require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'associations' do
    it { should belong_to(:user).optional }
    it { should have_many(:debts) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:national_id) }
    it { should validate_uniqueness_of(:national_id) }
  end

  describe 'custom validations' do
    it 'should validate cpf_or_cnpj' do
      person = Person.new(name: 'John Doe', national_id: CPF.generate)
      expect(person).to be_valid

      person.national_id = CPF.generate
      expect(person).to be_valid

      person.national_id = 'invalid_id'
      expect(person).not_to be_valid
    end
  end

  describe '#total_debts' do
    it 'returns the sum of all debt amounts' do
      person = Person.new(name: 'John Doe', national_id: CPF.generate)
      debt1 = person.debts.build(amount: 100)
      debt2 = person.debts.build(amount: 200)
      debt3 = person.debts.build(amount: 300)

      expect(person.total_debts).to eq(-600)
    end

    it 'returns 0 if there are no debts' do
      person = Person.new(name: 'John Doe', national_id: CPF.generate)

      expect(person.total_debts).to eq(0)
    end
  end
end
