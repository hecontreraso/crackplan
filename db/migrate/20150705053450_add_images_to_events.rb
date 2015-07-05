class AddImagesToEvents < ActiveRecord::Migration
  def change
  	change_table :events do |t|
      t.attachment :image
    end
  end
end
