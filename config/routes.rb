Rails.application.routes.draw do
  resources :users do #            vvvvv-- index of animations for user
    resources :animations, only: [:index, :show, :new, :create]
  end
  #                              vvvvv-- index of animations globally
  resources :animations, only: [:index, :show, :edit, :update, :destroy]

  resources :animations do
    resources :comments, shallow: true
    resources :frames, only: [:index, :show]
  end

  resources :frames, only: [:destroy]
  # TODO: routes for...
  # - sharing single frames publicly (attribute "published" or similar on a frame)
  # - copying frames into 

  resources :tags
end
