Rails.application.routes.draw do

  resources :logins, only: %i[new create]
  resources :posts, only: %i[index new create update edit show destroy]
  resources :registrations, only: %i[new create]
end
