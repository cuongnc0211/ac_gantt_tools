Rails.application.routes.draw do
  namespace :user do
    resources :members
    resources :projects
  end
  devise_for :users

  root 'user/dash_board#index'
end
