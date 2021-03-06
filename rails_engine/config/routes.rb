Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      resources :merchants, only: [:index, :show], defaults: { format: :json } do
        collection do
          get 'find', to: "merchants/find#show"
          get 'find_all', to: "merchants/find#index"
        end
      end

      resources :customers, only: [:index, :show], defaults: { format: :json} do
        collection do
          get 'find', to: "customers/find#show"
          get 'find_all', to: "customers/find#index"
        end
      end

      resources :items, only: [:index, :show], defaults: { format: :json } do
        collection do
          get "find", to: "items/find#show"
          get "find_all", to: "items/find#index"
        end
      end

      resources :invoice_items, only: [:index, :show], defaults: { format: :json } do
        collection do
          get 'find', to: "invoice_items/find#show"
          get "find_all", to: "invoice_items/find#index"
        end
      end

      resources :invoices, only: [:index, :show], defaults: { format: :json } do
        collection do
          get 'find', to: "invoices/find#show"
          get "find_all", to: "invoices/find#index"
        end
      end

      resources :transactions, only: [:index, :show], defaults: { format: :json } do
        collection do
          get 'find', to: "transactions/find#show"
          get "find_all", to: "transactions/find#index"
        end
      end
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
