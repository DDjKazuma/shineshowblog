class Article < ApplicationRecord
  has_many :article_tags
  has_many :tags, through: :article_tags
  has_one_attached :picture
  belongs_to :user
end
