module CollectionRenderable
  def render_collection(collection, serializer)
    @collection ||= collection
    render json: collection, meta: collection_meta, status: 200,
      each_serializer: serializer
  end

  def collection_meta
    { total: collection_model.all.length, page: params[:page],
      per_page: collection_model.per_page }
  end

  def collection_model
    Object.const_get(collection_model_name)
  end

  def collection_model_name
    @collection.class.to_s.split('::')[0]
  end
end
