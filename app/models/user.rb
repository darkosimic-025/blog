class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
