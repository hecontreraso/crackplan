class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|	
      t.timestamps null: false
      t.string :details,  null: false, default: ""
      t.string :where, 		null: false, default: ""
      t.string :scope, 		null: false, default: ""
      t.date :date,       null: false
      t.time :time,			  null: true
      t.string :image,    null: true
      t.integer :creator_id
    end
  end
end
