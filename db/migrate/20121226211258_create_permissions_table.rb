class CreatePermissionsTable < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :user_id
      t.integer :guild_id
      t.string  :permissions
    end
  end
end
