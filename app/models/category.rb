class Category < ActiveRecord::Base
  include Sluggable
  sluggable_column :name

  has_many :post_categories
  has_many :posts, through: :post_categories
  validates :name, presence: true, length: { minimum: 2}, uniqueness: true
end
