class AddColumnToBuyer < ActiveRecord::Migration
  def change
    add_column :buyers, :name, :string
  end
end
