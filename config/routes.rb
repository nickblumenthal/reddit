Rails.application.routes.draw do
  resource :user
  resource :session
  resources :subs do
    resources :posts, only: [:new, :edit]
  end
  resources :posts, except: [:new, :edit] do
    resources :comments, only: [:new]
  end
  resources :comments, only: [:create, :show]
end
