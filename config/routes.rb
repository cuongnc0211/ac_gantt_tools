Rails.application.routes.draw do
  namespace :user do
    resources :members
    resources :projects
    resources :tasks do
      member do
        get :modal_task_detail
      end
      collection do
        get :possible_parent_tasks
      end
    end
    resources :task_notes, only: [:create, :update]
  end
  devise_for :users

  # get "/dash_board", to: "user/dash_board#index"
  # root 'user/dash_board#home'

  get "/dash_board", to: "user/dash_board#home"
  root 'user/dash_board#index'

  namespace :api do
    namespace :v1 do
      resources :projects, only: :index
    end
  end


end
