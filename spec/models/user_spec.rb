require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:people).dependent(:nullify) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_confirmation_of(:password) }
end
