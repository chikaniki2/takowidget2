Rails.application.routes.draw do
  resources :posts do
    get :search, on: :collection
  end
  resources :rules
  devise_for :users, :controllers => {
  :confirmations => 'users/confirmations',
  :registrations => 'users/registrations',
  :sessions => 'users/sessions',
  :passwords => 'users/passwords'
}
end
