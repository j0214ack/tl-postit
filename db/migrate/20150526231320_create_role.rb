class CreateRole < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :role
      t.references :user_id
    end
  end
end
