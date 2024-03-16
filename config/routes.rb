Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get "/users", to: "users#index"
  get "/current_user", to: "application#current_user"
  get "/current_user/concerts", to: "concerts#current_user_concerts"
  get "/current_user/reservations", to: "reservations#current_user_reservations"
  get "/concerts", to: "concerts#index"
  get "/concerts/:id", to: "concerts#show"
  get "/reservations", to: "reservations#index"
  get "/reservations/:id", to: "reservations#show"

  post "/concerts", to: "concerts#create"
  post '/reservations', to: 'reservations#create'
  delete "/concerts/:id", to: "concerts#destroy"
end
