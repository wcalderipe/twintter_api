module Request
  module JsonHelper
    def json
      @json ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  module HttpAuthenticateHelper
    def current_user
      @current_user ||= create(:user, role: :admin)
    end

    def current_user=(user)
      @current_user = user
    end

    def current_user_credentials
      encode_credentials(current_user)
    end

    def encode_credentials(user)
      ActionController::HttpAuthentication::Basic.encode_credentials(
        user.username, 'password')
    end
  end
end
