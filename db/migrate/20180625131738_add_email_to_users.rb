class AddEmailToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :confirmation_at, :datetime, default: nil
  end
end
