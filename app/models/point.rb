# app/models/point.rb
class Point < ApplicationRecord
  has_many :surf_sessions, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end
