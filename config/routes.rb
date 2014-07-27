FrogPress::Application.routes.draw do
  devise_for :users

  root 'pages#index'
  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end
  resources :classroom
  resources :assignment, except: :index
<<<<<<< HEAD
=======
  resources :submission, except: :index
>>>>>>> master
  resources :users, only: [:show]

  delete '/classroom/:classid/users/:userid' => 'classroom#remove_student', as: 'remove_student'


end
