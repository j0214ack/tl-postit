module Voteable

  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable
  end

  def votes_sum
    up_votes_sum - down_votes_sum
  end

  def up_votes_sum
    self.votes.where(vote: true).size
  end

  def down_votes_sum
    self.votes.where(vote: false).size
  end

  def user_vote(user)
    if user
      self.votes.where(user_id: user.id).first
    end
  end
  
end
