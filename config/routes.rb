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
  resources :tasks, except: [:index]
  resources :users, only: :index
  namespace :form_schema do
    resources :text_inputs, only: [:create, :update, :destroy]
  end
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
