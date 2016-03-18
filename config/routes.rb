Rails.application.routes.draw do
  devise_for :users
  root to: 'errors#routing'

  get     '*a', to: 'errors#routing'
  post    '*a', to: 'errors#routing'
  put     '*a', to: 'errors#routing'
  patch   '*a', to: 'errors#routing'
  delete  '*a', to: 'errors#routing'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      
    end
  end
end
