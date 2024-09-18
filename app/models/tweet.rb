class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader
  mount_uploader :video, VideoUploader
end
