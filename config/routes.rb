Rails.application.routes.draw do
  get "static_pages/accueil"
  get "static_pages/about"
  get "static_pages/contact"
  get "static_pages/legal"
  root 'pages#accueil'
  
  # Devise avec contrôleur personnalisé
  devise_for :utilisateurs, controllers: {
    registrations: 'utilisateurs/registrations'
  }
  
  # Health check (déjà présent)
  get "up" => "rails/health#show", as: :rails_health_check

  # Routes pour les pages statiques (Module Information)
  get "about",   to: "pages#about"
  get "contact", to: "pages#contact"
  get "legal",   to: "pages#legal"

  # Routes pour le module Visualisation et Gestion (Objets connectés)
  resources :devices, except: [:destroy]

  # Namespace pour le module Administration
  namespace :admin do
    get "dashboard", to: "dashboard#index"
    resources :users
  end
end
