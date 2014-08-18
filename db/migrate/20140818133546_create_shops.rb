class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.string :token, limit: 32, null: false
      t.index :token, unique: true
    end
  end
end
