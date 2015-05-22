class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  # validates uniqueness: :user, scope: :voteable
  # validates_uniqueness_of :user, scope: :voteable
  validates_uniqueness_of :user, scope: [:voteable_type, :voteable_id]
end
