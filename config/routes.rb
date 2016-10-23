Rails.application.routes.draw do
  root "rounds#new"

  resources :rounds
end
