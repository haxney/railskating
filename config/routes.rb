Railskating::Application.routes.draw do
  root 'competitions#index'

  resources :competitions do
    get 'events/:number', to: 'events#show', as: :event
  end
end
