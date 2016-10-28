Rails.application.routes.draw do
  root "games#new"

  resources :games do
    resources :rounds
    patch '/rounds/:id/hit', to: 'rounds#hit'
    patch '/rounds/:id/double', to: 'rounds#double'
  end
end
