class CreateRaids < ActiveRecord::Migration
  def change
    create_table :raids do |t|
      t.hstore   :role_limits
      t.string   :where
      t.integer  :owner_id
      t.datetime :when
      t.datetime :start_at
      t.datetime :invite_at
    end
  end
end
