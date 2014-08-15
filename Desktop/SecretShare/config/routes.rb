SecretShareAjax::Application.routes.draw do
  resources :users, :only => [:create, :new, :show, :index] do
    resources :secrets, only: [:new]
  end
  resources :secrets, only: [:create]
  resource :session, :only => [:create, :destroy, :new]
  resources :friendships, only: [:create]

  post 'friendships/delete', to: 'friendships#destroy', as: 'delete_friendship'

  root :to => "users#show"
end
