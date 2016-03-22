class ApplicationController < ActionController::Base
  before_filter -> { request.format = :json }

  rescue_from ApplicationError do |e|
    render json: {
      error: {
        message: parse_error_message(e.message),
        class: e.class,
        status: e.status
      }
    }, status: e.status
  end

  private

    def parse_error_message(message)
      begin
        JSON.parse(message)
      rescue
        message
      end
    end
end
