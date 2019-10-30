Rails.application.routes.draw do
  namespace :user do
    resources :members
    resources :projects
    resources :tasks
  end
  devise_for :users

  root 'user/dash_board#index'
end
