class Post < ActiveRecord::Base
  include Voteable

  include Sluggable
  sluggable_column :title

  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories


  validates :title, presence: true
  validates :description, presence: true
  validates :url, presence: true

  def as_json(options = {})
    options[:except] ||= [:id, :user_id]
    super.as_json(options)
  end
end
