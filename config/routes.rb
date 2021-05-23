Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'home#index'

  namespace :admin do
    root to: 'home#index'
    devise_for :users, controllers: { registrations: 'admin/registrations', sessions: 'admin/sessions' }
    resources :categories
    resources :courses
  end

  mount ApiRoot => '/'
end
