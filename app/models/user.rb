class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true,
                       uniqueness: true,
                       length: { minimum: 3 },
                       format: { without: /\W/,
                                 message: "can't have non-word characters."}
  validates :password, presence: true, confirmation: true,
                       length: { minimum: 3 }, on: :create

  before_create :generate_slug

  def generate_slug
    self.slug = username
  end

  def to_param
    self.slug
  end
end
