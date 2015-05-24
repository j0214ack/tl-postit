class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories
  validates :name, presence: true, length: { minimum: 2}, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  before_create :generate_slug

  def generate_slug
    self.slug = name.downcase.gsub(/\s*[^a-zA-Z0-9]\s*/, "-").gsub(/-+/,"-")
    counter = 1
    other_post = Category.find_by(slug: self.slug)
    while( other_post && other_post != self ) do
      post_fix = "-#{counter}"
      counter += 1
      other_post = Category.find_by(slug: (self.slug + post_fix))
    end
    self.slug += post_fix
  end

  def to_param
    self.slug
  end
end
