Rails.application.routes.draw do
  devise_for :users

  root 'user/dash_board#index'
end
