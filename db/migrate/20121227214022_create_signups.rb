class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.integer :raid_id
      t.integer :character_id
      t.integer :user_id
      t.string  :acceptance_status
      t.string  :role
    end
  end
end
