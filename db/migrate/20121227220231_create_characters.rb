class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.integer :user_id
      t.integer :guild_id
      t.string :name
      t.string :character_class
      t.boolean :is_main
    end
  end
end
