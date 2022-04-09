Rails.application.routes.draw do
  devise_for :users, :controllers => {
  :confirmations => 'users/confirmations',
  :registrations => 'users/registrations',
  :sessions => 'users/sessions',
  :passwords => 'users/passwords'
}
end
