module HttpAuthenticable
  def current_user
    @current_user
  end

  def set_current_user(username, password)
    user = User.find_by_username(username)
    @current_user = user if user && user.valid_password?(password)
  end

  def authenticate_with_basic_auth!
    authenticate_or_request_with_http_basic do |username, password|
      set_current_user(username, password)
      if current_user
        true
      else
        render json: not_authenticated_json, status: 401
      end
    end
  end

  def not_authenticated_json
    {
      error: {
        message: ['Not authenticated'],
        status: 401
      }
    }
  end
end
