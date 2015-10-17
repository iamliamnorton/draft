Rails.application.routes.draw do
  root to: 'lobby#show'

  resource :lobby,
    only: [:show],
    controller: :lobby

  devise_for :users

  resource :credit,
    only: [:show, :create],
    controller: :credit

  resources :contests,
    only: [:show, :new, :create] do

    resources :entries,
      only: [:create]

    resources :draft_picks,
      only: [:create, :destroy]
  end
end
