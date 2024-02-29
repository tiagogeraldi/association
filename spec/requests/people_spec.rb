require 'rails_helper'

RSpec.describe "People", type: :request do
  let!(:user) { FactoryBot.create :user }
  let!(:person) { FactoryBot.create :person }

  before { sign_in user }

  describe "GET /people" do
    it "works! (now write some real specs)" do
      get people_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /people" do
    it "creates a new person" do
      expect {
        post people_path, params: { person: { name: "John Doe", national_id: CPF.generate } }
      }.to change(Person, :count).by(1)
      expect(response).to have_http_status(302)
    end

    it "fails to create a new person without a name" do
      expect {
        post people_path, params: { person: { national_id: CPF.generate } }
      }.to_not change(Person, :count)
      expect(response).to have_http_status(422)
    end
  end

  describe "GET /people/:id" do
    it "returns the specified person" do
      get person_path(person)
      expect(response).to have_http_status(200)
      expect(response.body).to include(person.name)
    end
  end

  describe "PUT /people/:id" do
    it "updates the specified person" do
      put person_path(person), params: { person: { name: "Jane Smith" } }
      expect(response).to have_http_status(302)
      expect(person.reload.name).to eq("Jane Smith")
    end

    it "fails to update the specified person" do
      put person_path(person), params: { person: { name: "" } }
      expect(response).to have_http_status(422)
      expect(person.reload.name).to_not eq("")
    end
  end

  describe "DELETE /people/:id" do
    it "deletes the specified person" do
      expect {
        delete person_path(person)
      }.to change(Person, :count).by(-1)
      expect(response).to have_http_status(302)
    end
  end
end
