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

  root 'user/dash_board#index'
end
