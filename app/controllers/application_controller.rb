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

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {
      error: {
        message: parse_error_message(e.message),
        class: e.class.name,
        status: 404
      }
    }, status: 404
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
