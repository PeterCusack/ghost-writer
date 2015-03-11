class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.string :title
      t.text :content
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
