require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'associations' do
    it { should belong_to(:user).optional }
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

end
