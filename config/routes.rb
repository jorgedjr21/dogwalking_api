Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :pets
      resources :dog_walkings, only: %i[index show create] do
        member do
          put :start_walk
          put :finish_walk
        end
      end
    end
  end
end
