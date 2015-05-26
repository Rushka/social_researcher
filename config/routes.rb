Rails.application.routes.draw do
  get 'friends', to: 'friends#index'
  get 'friends/build', to: 'friends#build'  

  post 'friends/validate', to: 'friends#validate'
end
