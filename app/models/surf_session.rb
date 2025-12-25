class SurfSession < ApplicationRecord
  belongs_to :user
  belongs_to :point, optional: true

  has_one_attached :photo

  validates :session_date, presence: true
  validates :duration_minutes, presence: true

  before_destroy :purge_photo

  private

  def purge_photo
    photo.purge_later if photo.attached?
  end
end
