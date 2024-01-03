class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums do |t|
      t.string :name
			t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
		add_index :albums, [:name, :artist_id], unique: true
  end
end
