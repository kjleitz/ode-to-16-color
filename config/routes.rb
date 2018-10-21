Rails.application.routes.draw do
  resources :users do #            vvvvv-- index of animations for user
    resources :animations, only: [:index, :show, :new, :create]
  end
  #                              vvvvv-- index of animations globally
  resources :animations, only: [:index, :show, :edit, :update, :destroy]

  resources :animations do
    resources :frames, only: [:index, :show]
    resources :comments, shallow: true
    resources :votes, only: [:create, :update, :destroy]
  end

  resources :comments do
    resources :votes, only: [:create, :update, :destroy]
  end

  resources :frames, only: [:destroy]
  # TODO: routes for...
  # - sharing single frames publicly (attribute "published" or similar on a frame)
  # - copying frames into 

  resources :tags
end
