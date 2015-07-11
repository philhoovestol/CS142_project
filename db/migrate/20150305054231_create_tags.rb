class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :x1
      t.integer :y1
      t.integer :wid
      t.integer :hei
      t.integer :user_id
      t.integer :photo_id
    end
  end
end
