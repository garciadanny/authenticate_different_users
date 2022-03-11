require "rails_helper"

RSpec.describe "UsersController", type: :request do


  describe "sign_up" do
    it "creates user from email / password" do
      expect {
        post '/users', params: user_params
      }.to change{ User.count }.from(0).to(1)
    end

    it "redirects to admin dashboard for admin signup" do
      post '/users', params: user_params(user_type: 'admin')
      expect response.should redirect_to '/admin_dashboard'
    end

    it "redirects to guardian dashboard for guardian signup" do
      post '/users', params: user_params(user_type: 'guardian')
      expect response.should redirect_to '/guardian_dashboard'
    end

  end

  def user_params(opts = {})
    { user: { user_type: 'admin',
              email: 'admin@foo.com',
              password: 'super_secret' }.merge(opts)}
  end

end
