Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :products do
      resources :variants do
        get :price_points, on: :member
      end
    end

    delete '/price_points/:id', to: 'price_points#destroy', as: :price_point
    resources :price_point_models
  end
end
