class Api::V1::UsersController < Api::V1::BaseController
  def index
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, serializer: ::V1::UserSerializer
    else
      fail ModelValidationError.new(user.errors)
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :username, :first_name, :last_name,
        :password, :password_confirmation)
    end
end
