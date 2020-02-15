Rails.application.routes.draw do
  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'sessions',
      registrations: 'registrations',
    }
  resources :registers, only: :create
  resources :flows do
    resources :tasks, only: [:index]
  end
  resources :flow_instances, only: [:update]
  resources :task_instances
  resources :tasks, except: [:index]
  resources :users, only: :index
  namespace :form_schema do
    resources :forms do
      resources :form_inputs, controller: 'forms/form_inputs'
    end
  end
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
