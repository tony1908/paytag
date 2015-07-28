class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :numEx
      t.string :numInt
      t.string :colonia
      t.string :delegacion
      t.string :state
      t.string :city
      t.integer :cp

      t.timestamps null: false
    end
  end
end
