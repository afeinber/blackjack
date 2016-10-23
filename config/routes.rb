Rails.application.routes.draw do
  root "games#new"

  resources :games do
    resources :rounds
  end
end
