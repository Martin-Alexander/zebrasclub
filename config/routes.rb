Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      omniauth_callbacks: 'users/omniauth_callbacks'
  }

  scope '(:locale)', locale: /fr|en|es/ do
    root to: 'pages#home'
    # Might not work but I want to redirect_to home page when i make a post request in the MailChimp email form.
    post "/home_user", to: "pages#new_user", as: "new_user"
  end

  # grid with package items
  get "/package", to: "pages#package", as: "package"

  get "/package/main", to: "pages#package_main", as: "package_main"

  # returns .js to choose item of a certain category
  post "/package/index", to: "items#package_index", as: "package_items"

  # returns .js to view item/brand details and change size
  post "/package/show", to: "items#package_show", as: "package_item"

  # replaces package item of same category as new package item
  post "/replace", to: "orderitems#package_replace", as: "package_replace"

  # list of individual items
  get "/items", to: "items#index", as: "items"

  # individual item/brand details (not inside package view)
  get "/items/:id", to: "items#show", as: "item"

  # list of past orders
  get "/orders", to: "orders#index", as: "orders"

  # view shopping cart
  get "/orderitems", to: "orderitems#index", as: "orderitems"

  # adding an item to your cart

  resources :order, only: [] do
    resources :payments, only: [:create]
  end

  # post "/orderitems", to: "orderitems#create", as: "new_orderitem"

  # editting and removing items from your cart
  patch "/orderitems/:id", to: "orderitems#update", as: "edit_orderitem"
  delete "/orderitems/:id", to: "orderitems#destroy", as: "destroy_orderitem"

  get "/done", to: "pages#done", as: "done"
  # post "/done", to: "pages#done", as: "doneorder"
end
