class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :uf, null: false, limit: 2
      t.string :name, null: false, limit: 20
    end
  end
end
