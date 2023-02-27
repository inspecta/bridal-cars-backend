Rails.application.routes.draw do
  
  # car api endpoints
  # post '/api/v1/', to: 'api/v1#create'

  namespace :api do
    namespace :v1 do
      resources :cars, only: [:index, :show, :create, :destroy]
    end
  end

end
