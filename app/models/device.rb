class Device < ApplicationRecord
    validates :name, :category, :location, presence: true
  
    scope :filter_by_active, ->(active) { where(active: active) }
    scope :search, ->(keyword) {
      where("name LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%")
    }
  end
  