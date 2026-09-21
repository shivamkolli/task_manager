require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/users/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /users" do
    it "creates a user and redirects" do
      expect {
        post users_path, params: {
          user: {
            email_address: "test@example.com",
            password: "Password123!"
          }
        }
      }.to change(User, :count).by(1)

      expect(response).to have_http_status(:redirect)
    end
  end
end
