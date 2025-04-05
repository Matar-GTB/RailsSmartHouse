class Utilisateur < ApplicationRecord
  # Modules Devise de base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Système de points et niveaux
  # On ajoute une colonne points (à ajouter par migration) et on considère que role est mis à jour selon les points.
  LEVELS = {
    debutant: 0,
    intermediaire: 10,
    avance: 30,
    expert: 60
  }

  # Méthode pour obtenir le niveau en fonction des points
  def level_name
    pts = self.points || 0
    case pts
    when LEVELS[:debutant]...LEVELS[:intermediaire]
      "Débutant"
    when LEVELS[:intermediaire]...LEVELS[:avance]
      "Intermédiaire"
    when LEVELS[:avance]...LEVELS[:expert]
      "Avancé"
    else
      "Expert"
    end
  end

  # Vérifie et met à jour le rôle en fonction des points accumulés
  def check_level_up!
    if points >= LEVELS[:expert] && role != 'admin'
      update(role: 'admin')
    elsif points >= LEVELS[:avance] && role == 'simple'
      update(role: 'complexe')
    end
  end

  # Méthodes booléennes pratiques
  def admin?
    role == 'admin'
  end

  def complexe?
    role == 'complexe'
  end

  def simple?
    role == 'simple'
  end
end
