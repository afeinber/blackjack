Rails.application.routes.draw do
  root "games#new"

  resources :games do
    resources :rounds
    patch '/rounds/:id/hit', to: 'rounds#hit'
  end
end
