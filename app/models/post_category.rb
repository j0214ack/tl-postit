class PostCategory < ActiveRecord::Base
  belongs_to :post
  belongs_to :category
  has_many :votes, as: :voteable
end
