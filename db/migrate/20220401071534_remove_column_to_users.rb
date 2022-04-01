class RemoveColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
  end
end
