module Voteable
  def votes_sum
    up_votes_sum - down_votes_sum
  end

  def up_votes_sum
    self.votes.where(vote: true).size
  end

  def down_votes_sum
    self.votes.where(vote: false).size
  end
end
