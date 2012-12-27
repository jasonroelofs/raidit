class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :signup_id
      t.integer :user_id
      t.string  :comment
    end
  end
end
