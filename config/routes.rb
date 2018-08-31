Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products, shallow: true do
    resources :descriptions
  end
  resources :bills, shallow: true do
    resources :lists, only: [:create, :show, :edit, :update, :create, :destroy] do
      resources :wholesales, only: :create
    end
  end

  get "bills/:bill_id/lists/new_retail", to: "lists#new_retail", as: :new_bill_retail
  get "bills/:bill_id/lists/new_wholesale", to: "lists#new_wholesale", as: :new_bill_wholesale
  get "bills/:bill_id/lists/new_purchase", to: "lists#new_purchase", as: :new_bill_purchase
end
