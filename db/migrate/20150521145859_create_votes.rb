class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :vote
      t.integer :voteable_id
      t.string :voteable_type
    end
  end
end
