class UsersController < Clearance::UsersController
  private

  def user_params
    params.fetch(:user, {}).permit(:username, :email, :password)
  end
end