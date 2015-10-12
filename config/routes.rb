Rails.application.routes.draw do
  root to: 'lobby#show'

  resource :lobby,
    only: [:show],
    controller: :lobby
end
