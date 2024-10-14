Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: [:create, :destroy] # Anidar comments bajo posts
    member do
      post "like"
      post "dislike"
    end
  end

  get "home/index"
  devise_for :users

  # Definir la ruta raíz para que apunte al home
  root "home#index"

  # Otras rutas necesarias
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
