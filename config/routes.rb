Rails.application.routes.draw do
  devise_for :users
  as :user do
    get "signin" => "devise/sessions#new"
    post "signin" => "devise/sessions#create"
    delete "signout" => "devise/sessions#destroy"
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      use_doorkeeper do
        controllers tokens: 'tokens'
        skip_controllers :authorizations, :applications,
                         :authorized_applications
      end

      namespace :oauth do
        namespace :me do
          post :forgot
          post :reset
          get :confirm_email
        end
      end

      resources :requests
      resources :users, only: [:create, :edit, :update]
      resources :candidates, only: [:create, :update]
      resources :chanels, only: :index
      resources :levels, only: :index
      resources :languages, only: :index
      resources :positions, only: :index
      get "users/get"
      post "users/set_role"
      post "candidates/format_cv"
    end
  end
end
