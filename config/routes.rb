Rails.application.routes.draw do
  root 'animations#index'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do #            vvvvv-- index of animations for user
    resources :animations, only: [:index]
  end
  #                              vvvvv-- index of animations globally
  resources :animations, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  resources :animations, only: [] do
    resources :frames, only: [:index, :show]
    resources :comments, shallow: true
    resources :votes, only: [:create, :update, :destroy]
  end

  resources :comments, only: [] do
    resources :votes, only: [:create, :update, :destroy]
  end

  resources :frames, only: [:destroy]
  # TODO: routes for...
  # - sharing single frames publicly (attribute "published" or similar on a frame)
  # - copying frames into 

  resources :tags
end
