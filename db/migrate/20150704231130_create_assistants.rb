class CreateAssistants < ActiveRecord::Migration
  def change
    create_table :assistants do |t|
		t.belongs_to :user, index: true 
		t.belongs_to :event, index: true
		t.string :role, null: false, default: "A" #A for assistant, C for creator
		t.timestamps null: false
    end
  end
end
