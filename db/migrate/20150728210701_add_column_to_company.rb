class AddColumnToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :confirmation_token, :string
    add_column :companies, :confirmed_at, :datetime
    add_column :companies, :confirmation_sent_at, :datetime
    add_column :companies, :unconfirmed_email, :string
  end
end
