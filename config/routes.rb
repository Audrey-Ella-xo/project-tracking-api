Rails.application.routes.draw do
  resources :projects do
    resources :todos do
      resources :items 
    end
  end
end
