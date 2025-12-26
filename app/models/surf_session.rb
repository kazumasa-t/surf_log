class SurfSession < ApplicationRecord
  belongs_to :user
  belongs_to :point, optional: true

  validates :session_date, presence: true
  validates :duration_minutes, presence: true
end
