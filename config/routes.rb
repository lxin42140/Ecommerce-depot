Rails.application.routes.draw do
  resources :hotels
  devise_for :users
  root to: "products#index"
  # match '*path' => redirect("products#index"), via: [:get]

  # get '/sale_transactions',
  #     to: 'sale_transactions#index',
  #     constraints: ->(request){  User.current_user.present? && User.current_user.access_right_enum == 1}
  
  #resources
  resources :carts, :path => "my_cart"
  resources :users
  resources :sale_transactions, :path => "my_transactions"
  resources :sale_transaction_line_items
  resources :products
  resources :product_parts
  resources :hotels
end
