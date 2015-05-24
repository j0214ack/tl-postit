class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  has_many :votes, as: :voteable
  include Voteable

  validates :title, presence: true
  validates :description, presence: true
  validates :url, presence: true
  validates :slug, presence: true, uniqueness: true

  before_create :generate_slug

  def generate_slug
    self.slug = title.downcase.gsub(/\s*[^a-zA-Z0-9]\s*/, "-").gsub(/-+/,"-")
    counter = 1
    other_post = Post.find_by(slug: self.slug)
    while( other_post && other_post != self ) do
      post_fix = "-#{counter}"
      counter += 1
      other_post = Post.find_by(slug: (self.slug + post_fix))
    end
    self.slug += post_fix
  end

  def to_param
    self.slug
  end
end
