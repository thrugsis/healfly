class AddClearanceToUsers < ActiveRecord::Migration[5.0]
  def self.up
    change_table :users do |t|
    end

    add_index :users, :email
    add_index :users, :remember_token

    users = select_all("SELECT id FROM users WHERE remember_token IS NULL")

    users.each do |user|
      update <<-SQL
        UPDATE users
        SET remember_token = '#{Clearance::Token.new}'
        WHERE id = '#{user['id']}'
      SQL
    end
  end

  def self.down
    change_table :users do |t|
    end
  end
end
