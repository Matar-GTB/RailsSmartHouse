class Utilisateur < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    role == "admin"
  end

  def simple?
    role == "simple"
  end

  def complexe?
    role == "complexe"
  end
end
