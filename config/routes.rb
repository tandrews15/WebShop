Rails.application.routes.draw do
  resources :ordered_items
  resources :orders
  devise_for :users
  resources :payments
  resources :category_items

  resources :items do
    collection do
      get :feedbacks_add
      get :feedbacks
    end
  end
  
  resources :feedbacks
  
  resources :categories
  resources :stores
  resources :ordered_items

  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root 'welcome#index'
end
