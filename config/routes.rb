FrogPress::Application.routes.draw do
  devise_for :users

  root 'pages#index'
  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end

  resources :classroom
  resources :assignment, except: :index


end
