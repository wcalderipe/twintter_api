class Api::V1::UsersController < Api::V1::BaseController
  after_action :verify_authorized

  def index
    authorize User
    render_collection(users, ::V1::UserSerializer)
  end

  def show
    authorize user
    render json: user, status: 200, serializer: ::V1::UserSerializer
  end

  def create
    authorize User
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, serializer: ::V1::UserSerializer
    else
      fail ModelValidationError.new(user.errors)
    end
  end

  def update
    authorize user
    if user.update(user_params)
      render json: user, status: 200, serializer: ::V1::UserSerializer
    else
      fail ModelValidationError.new(user.errors)
    end
  end

  def destroy
    authorize user
    user.destroy
    head 204
  end

  private

    def user
      @user ||= User.find(params[:id])
    end

    def users
      User.paginate(:page => params[:page])
    end

    def user_params
      params.require(:user).permit(:email, :username, :first_name, :last_name,
        :password, :password_confirmation)
    end
end
