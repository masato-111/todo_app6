Rails.application.routes.draw do
  root "home#index"
  # get 'tasks/new', to: 'tasks#new', as: :new_task
  # post 'tasks/new', to: 'tasks#create'
  resources :tasks
end
