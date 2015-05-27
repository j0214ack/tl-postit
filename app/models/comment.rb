class Comment < ActiveRecord::Base
  include Voteable

  belongs_to :user
  belongs_to :post

  def as_json(options = {})
    options[:except] ||= [:id, :user_id, :post_id]
    super.as_json(options)
  end
end
