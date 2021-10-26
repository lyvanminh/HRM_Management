Rails.application.routes.draw do
  devise_for :users
  as :user do
    get "signin" => "devise/sessions#new"
    post "signin" => "devise/sessions#create"
    delete "signout" => "devise/sessions#destroy"
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      # TODO: routes
    end
  end
end
