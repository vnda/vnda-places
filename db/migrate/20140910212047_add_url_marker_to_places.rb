class AddUrlMarkerToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :marker_url, :string
  end
end
