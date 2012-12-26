class AddLoginTokensHstoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login_tokens, :hstore
  end
end
