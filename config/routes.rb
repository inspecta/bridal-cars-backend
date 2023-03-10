Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  # car api endpoints

  namespace :api do
    namespace :v1 do
      resources :cars, only: [:index, :show, :create, :destroy]
    end
  end

end
