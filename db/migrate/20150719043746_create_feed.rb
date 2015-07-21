class CreateFeed < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.belongs_to :user, index: true
      t.belongs_to :event, index: true
      t.integer :feed_creator_id
      t.timestamps null: false
    end
  end
end
