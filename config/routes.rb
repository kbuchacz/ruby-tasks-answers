Rails.application.routes.draw do
  resources :movies do
    member do
      post :rate
    end
    resources :actors, controller: "movies/actors", only: [:index, :create] do
    end
  end

  resources :actors do
    member do
      post :rate
    end
  end
end
