class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :confirmation_at, :datetime, default: nil
    add_column :users, :otp, :integer, limt: 6
  end
end
