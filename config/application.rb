require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module TwintterApi
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true

    WillPaginate.per_page = 30
  end
end
