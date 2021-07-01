Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/sign-up' => 'users#signup'
      post '/login' => 'users#login'
      resources :forms 
      resources :questions
      resources :answer, only: %i[create show]
    end
  end
end
