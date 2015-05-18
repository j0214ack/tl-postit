class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password validations: false

  validates :username, presence: true, length: { minimum: 3 }
  validates :password, presence: true, confirmation: true,
                       length: { minimum: 3 }, on: :create

end
