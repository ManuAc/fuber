Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        member do
          get 'cabs', to: 'users#cabs'
          post 'book', to: 'users#book'
        end
      end

      resources :cabs

      resources :drivers

      resources :trips do
        member do
          post 'start', to: 'trips#start'
          post 'end', to: 'trips#end'
        end
      end
    end
  end
end
