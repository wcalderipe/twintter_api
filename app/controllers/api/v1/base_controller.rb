class Api::V1::BaseController < ApplicationController
  include ::HttpAuthenticable

  before_filter :authenticate_with_basic_auth!

  protected

    def render_collection(model, serializer)
      render json: model.paginate(page: params[:page]), meta: collection_meta(model),
        status: 200, each_serializer: serializer
    end

    def collection_meta(model)
      { total: model.all.length, page: params[:page], per_page: model.per_page }
    end
end
