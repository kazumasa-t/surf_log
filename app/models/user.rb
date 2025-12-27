class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ------------------------------
  # ActiveStorage
  # ------------------------------
  has_one_attached :avatar
  has_one_attached :cover_image

  # ------------------------------
  # Associations
  # ------------------------------
  has_many :surf_sessions, dependent: :destroy
  has_many :share_links, dependent: :destroy
end
