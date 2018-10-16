Rails.application.routes.draw do
  resources :comment_votes
  resources :animation_votes
  resources :comments
  resources :tags
  resources :animations
  resources :frames
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
