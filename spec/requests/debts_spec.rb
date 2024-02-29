require 'rails_helper'

RSpec.describe "Debts", type: :request do
  let!(:user) { FactoryBot.create :user }

  before { sign_in user }

  describe "GET /debts" do
    it "returns a success response" do
      get debts_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /debts" do
    let!(:person) { FactoryBot.create :person }

    context "when creating a debt fails" do
      it "does not create a new debt" do
        expect {
          post debts_path, params: {
            debt: {
              amount: nil, # Invalid amount
              description: "Test Debt",
              person_id: person.id
            }
          }
        }.to_not change(Debt, :count)
        expect(response).to have_http_status(422) # Unprocessable Entity
      end
    end

    context "when creating a debt succeeds" do
      it "creates a new debt" do
        expect {
          post debts_path, params: {
            debt: {
              amount: 100,
              description: "Test Debt",
              person_id: person.id
            }
          }
        }.to change(Debt, :count).by(1)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "DELETE /debts/:id" do
    let!(:debt) { FactoryBot.create(:debt) }

    it "deletes the specified debt" do
      expect {
        delete debt_path(debt)
      }.to change(Debt, :count).by(-1)
      expect(response).to have_http_status(302)
    end
  end
end
