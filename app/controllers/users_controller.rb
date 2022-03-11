class UsersController < Clearance::UsersController

  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_to user_type_path(@user.user_type)
    else
      render template: "users/new"
    end
  end


  private

  def user_type_path(user_type)
    h = { 'admin'    => admin_dashboard_path,
          'guardian' => guardian_dashboard_path,
          'vendor'   => vendor_dashboard_path }
    h[user_type]
  end

  def user_from_params
    email, pw, type = [:email, :password, :user_type].map { |key| user_params.delete(key) }

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = pw
      user.user_type = type
    end
  end

end
