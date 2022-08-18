Rails.application.routes.draw do
  get 'my_portfolio_update', to: 'users#my_portfolio_update'
  get "user_stock", to: "user_stocks#destroy"
  resources :user_stocks, only: [:create, :destroy]
  root "welcome#index"
  get "my_portfolio", to: "users#my_portfolio"
  devise_for :users

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  get "search_stock", to: "stocks#search"
  get "user_stocks", to: "user_stocks#create"
end 
