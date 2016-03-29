class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :null_session

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

  rescue_from Pundit::NotAuthorizedError do |e|
    render json: {
      error: {
        message: 'Not authorized',
        class: e.class.name,
        status: 403
      }
    }, status: 403
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
