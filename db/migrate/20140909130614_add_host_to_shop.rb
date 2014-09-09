class AddHostToShop < ActiveRecord::Migration
  def change
    add_column :shops, :host, :string
  end
end
