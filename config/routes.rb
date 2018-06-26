Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, constraints: {format: :json} do
    namespace :v1 do
      resource :users, only: [:index] do
        collection do
          post 'sign_up', to: 'users#sign_up'
        end
        put '/:id/confirmation', to: 'users#account_confirmation'
      end
    end
  end
end
