class AddColumnToLetters < ActiveRecord::Migration
  def change
  	add_column :letters, :lob_object_id, :string
  end
end
