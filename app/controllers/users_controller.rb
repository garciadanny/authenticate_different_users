class UsersController < Clearance::UsersController
  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_to user_root_path
    else
      render template: "users/new"
    end
  end


  private

  def user_root_path
    case @user.user_type
    when "guardian" then guardian_dashboard_index_path
    when "admin" then admin_dashboard_index_path
    end
  end

  def user_from_params
    email, pw, type = [:email, :password, :user_type].map { |key| user_params.delete(key) }

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = pw
      user.user_type = type
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :user_type)
  end
end
