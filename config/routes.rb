Railskating::Application.routes.draw do
  root 'competitions#index'

  resources :competitions, only: [:index, :show] do
    resources :events, only: [:index]
    get 'events/:number', to: 'events#show', as: :event
  end
end
