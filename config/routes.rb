Railskating::Application.routes.draw do
  root 'competitions#index'

  resources :marks, :rounds, :adjudicators, :couples, :levels, :events, :dances,
    :sections, :teams, :competitions, :users, only: [:index, :show]
end
