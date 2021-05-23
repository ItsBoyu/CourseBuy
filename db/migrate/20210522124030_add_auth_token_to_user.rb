class AddAuthTokenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :auth_token, :string
    add_index :users, :auth_token, unique: true

    User.all.each do |user|
      user.regenerate_auth_token
    end
  end
end
