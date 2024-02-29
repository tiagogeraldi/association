class Debt < ApplicationRecord
  belongs_to :person

  validates :amount, presence: true
end
