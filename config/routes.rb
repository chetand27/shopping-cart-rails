Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, constraints: {format: :json} do
    namespace :v1 do
      resources :users, only: [:show] do
        collection do
          post 'sign_up', to: 'users#sign_up'
        end
        post '/confirmation', to: 'users#account_confirmation'
        post '/reset_otp', to: 'users#reset_verification_code'
      end
    end
  end
end
