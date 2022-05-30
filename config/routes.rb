Rails.application.routes.draw do

  resources :posts do
    get :search, on: :collection
    get :search_post, on: :collection
  end

  resources :likes do
    post :dlt,      on: :collection
    get  :list,     on: :collection
    get  :list_all, on: :collection
  end
  devise_for :users, :controllers => {
  :confirmations => 'users/confirmations',
  :registrations => 'users/registrations',
  :sessions => 'users/sessions',
  :passwords => 'users/passwords'
  }

  resources :users do
    get :profile, on: :collection
  end
  
  resources :embeds
end
