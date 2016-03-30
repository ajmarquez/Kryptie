class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :domain
      t.text :body
      t.text :current_hash
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
 end
