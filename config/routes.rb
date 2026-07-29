Rails.application.routes.draw do
  get "professors/new"
  root "home#index"
  # get 'tasks/new', to:'tasks#new', as: :new_task
  # post 'tasks/new', to:'tasks#create'
  # get 'tasks', to:'tasks#index', as: :tasks
  # get 'tasks/:id', to:'tasks#show', as: :task
  # get 'tasks/:id/edit', to:'tasks#edit', as: :edit_task
  # patch 'tasks/:id', to: 'tasks#update'
  # destroy 'tasks/:id' to: 'tasks#delete'
  resources :tasks
  resources :professors
end
