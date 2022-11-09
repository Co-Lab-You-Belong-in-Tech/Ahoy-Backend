Rails.application.routes.draw do

  get 'users/me'
  patch 'users/me', to: 'users#update'

  devise_for :users,
    controllers: {
      registrations: :registrations,
      sessions: :sessions,
    }

  patch 'match', to: 'matches#match_request'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
