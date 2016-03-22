Rails.application.routes.draw do
  root to: 'errors#routing'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update, :destroy]
    end
  end

  get     '*a', to: 'errors#routing'
  post    '*a', to: 'errors#routing'
  put     '*a', to: 'errors#routing'
  patch   '*a', to: 'errors#routing'
  delete  '*a', to: 'errors#routing'
end
