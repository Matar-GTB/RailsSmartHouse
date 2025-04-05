Rails.application.routes.draw do
  root 'pages#accueil'
  
  # Devise avec contrôleur personnalisé
  devise_for :utilisateurs, controllers: {
    registrations: 'utilisateurs/registrations'
  }
  get "up" => "rails/health#show", as: :rails_health_check
end


