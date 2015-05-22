class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  has_many :votes, as: :voteable
  include Voteable
end
