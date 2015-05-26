Rails.application.routes.draw do
  get 'friends', to: 'friends#index'
  get 'friends/validation', to: 'friends#validation'
  get 'friends/build', to: 'friends#build'  
end
