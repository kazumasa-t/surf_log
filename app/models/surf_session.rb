class SurfSession < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :session_date, presence: true
end
