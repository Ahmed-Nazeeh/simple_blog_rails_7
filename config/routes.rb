Rails.application.routes.draw do
  root 'home_page#index'

  resources :logins, only: %i[new create]
  resources :posts, only: %i[index new create update edit show destroy]
  resources :registrations, only: %i[new create]
end
