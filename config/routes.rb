Rails.application.routes.draw do
  get "tasks/new"
  root "home#index"
  # get 'tasks/new', to: 'tasks#new', as: :new_task
  # post 'tasks/new', to: 'tasks#create'
  # get 'tasks', to:'tasks#index', as: :tasks
  # get 'tasks/:id', to:'tasks#show', as: :task
  resources :tasks
end
