# app/models/share_link.rb
class ShareLink < ApplicationRecord
  belongs_to :user

  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(10)
  end
end
