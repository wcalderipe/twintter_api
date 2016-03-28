class Api::V1::BaseController < ApplicationController
  include ::HttpAuthenticable
  include ::CollectionRenderable

  before_filter :authenticate_with_basic_auth!
end
