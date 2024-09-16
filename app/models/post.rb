class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true
  def self.ransackable_attributes(auth_object = nil)
    ["body", "comments_count", "created_at", "id", "likes_count", "title", "updated_at", "user_id"]
  end
end
