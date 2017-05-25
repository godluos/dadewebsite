Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :products, :comments
    resources :messages do
      member do
        post :publish
        post :hide
      end
    end
  end

  get 'comments', to: 'welcome#index'
  post 'comments', to: 'welcome#create'

  resources :products, :kinds, :categories

  resources :messages do
    collection do
      get :search
    end
  end



  root "welcome#index"
end
