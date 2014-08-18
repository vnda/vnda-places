class AddShopToPlaces < ActiveRecord::Migration
  def change
    change_table :places do |t|
      t.references :shop
      t.foreign_key :shops
    end

    unless reverting? || !Place.exists?
      shop = Shop.first || Shop.create!(name: 'placeholder')
      execute("UPDATE places SET shop_id = #{shop.id}")
    end
    change_column_null(:places, :shop_id, false)
  end
end
