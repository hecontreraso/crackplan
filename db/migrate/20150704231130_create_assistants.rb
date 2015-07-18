class CreateAssistants < ActiveRecord::Migration
  def change
    create_table :assistants do |t|
			t.belongs_to :user, index: true
			t.belongs_to :event, index: true
			t.timestamps null: false
    end
    add_index :assistants, [:user_id, :event_id], unique: true
  end
end
