Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v1 do
      resources :articles
      resources :user_articles
      resources :users
      resources :comments
      get '/user/my_article', to: 'users#get_articles', as: :get_articles
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
