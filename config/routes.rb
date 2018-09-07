Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products, shallow: true do
    resources :descriptions, only: [:new, :create, :update, :edit, :destroy]
  end
  resources :bills, shallow: true do
    resources :lists do
      resources :wholesales, only: :create
    end
  end

  get "customers", to: "pages#customers", as: :customers
  get "buyers/new_buyer", to: "buyers#new_buyer", as: :new_buyer
  get "buyers/new_seller", to: "buyers#new_seller", as: :new_seller
  get "buyers/:id/edit_buyer", to: "buyers#edit_buyer", as: :edit_buyer
  get "buyers/:id/edit_seller", to: "buyers#edit_seller", as: :edit_seller
  get "buyers/all_buyers", to: "buyers#all_buyers", as: :all_buyers
  get "buyers/all_sellers", to: "buyers#all_sellers", as: :all_sellers

  resources :details, only: [:new, :create, :index, :destroy]

  resources :buyers, only: [:create, :update, :destroy, :show]

  get "products/:id/new_similar", to: "products#new_similar", as: :new_similar_product



  get "bills/:bill_id/lists/new_retail", to: "lists#new_retail", as: :new_bill_retail
  get "bills/:bill_id/lists/new_wholesale", to: "lists#new_wholesale", as: :new_bill_wholesale
  get "bills/:bill_id/lists/new_purchase", to: "lists#new_purchase", as: :new_bill_purchase
  get "bills/:bill_id/lists/:id/edit_retail", to: "lists#new_retail", as: :edit_list_retail
  get "bills/:bill_id/lists/:id/edit_wholesale", to: "lists#new_wholesale", as: :edit_list_wholesale
  get "bills/:bill_id/lists/:id/edit_purchase", to: "lists#new_purchase", as: :edit_list_purchase
end
