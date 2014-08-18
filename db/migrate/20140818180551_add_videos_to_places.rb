class AddVideosToPlaces < ActiveRecord::Migration
  def change
    change_table :places do |t|
      t.string :videos, array: true
    end
  end
end
