class Api::V1::BaseController < ApplicationController
  include Pundit
  include ::HttpAuthenticable
  include ::CollectionRenderable

  after_action :verify_authorized

  before_filter :authenticate_with_basic_auth!
end
