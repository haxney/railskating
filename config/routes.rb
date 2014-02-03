Railskating::Application.routes.draw do
  root 'competitions#index'

  resources :competitions, only: [:index, :show] do
    get 'events/:number', to: 'events#show', as: :event
  end
end
