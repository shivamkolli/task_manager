require "rails_helper"
RSpec.describe "Users", type: :request do
  let(:headers) do
    {
      "HTTP_HOST" => "localhost"
    }
  end

  describe "GET /new" do
    it "returns http success" do
      get "/users/new", headers: headers

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /users" do
    xit "creates a user and redirects" do
      expect {
        post users_path,
          params: {
            user: {
              email_address: "test@example.com",
              password: "Password123!",
              password_confirmation: "Password123!"
            }
          },
          headers: headers
      }.to change(User, :count).by(1)

      expect(response).to have_http_status(:redirect)
    end
  end
end
