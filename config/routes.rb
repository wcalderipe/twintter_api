Rails.application.routes.draw do
  DEFAULT_ACTIONS = [:index, :show, :create, :update, :destroy]

  root to: 'errors#routing'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: DEFAULT_ACTIONS do
        resources :posts, only: DEFAULT_ACTIONS
      end

      resources :posts, only: [] do
        resources :comments, only: DEFAULT_ACTIONS
      end
    end
  end

  get     '*a', to: 'errors#routing'
  post    '*a', to: 'errors#routing'
  put     '*a', to: 'errors#routing'
  patch   '*a', to: 'errors#routing'
  delete  '*a', to: 'errors#routing'
end
