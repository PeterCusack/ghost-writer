class AddColumnsToLetters < ActiveRecord::Migration
  def change
  	add_column :letters, :sent, :boolean, default: false
  	add_column :letters, :letter_number, :integer
  	add_index :letters, :letter_number
  end
end
