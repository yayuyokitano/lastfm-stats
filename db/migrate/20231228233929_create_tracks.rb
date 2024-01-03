class CreateTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :tracks do |t|
      t.string :name
			t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
		add_index :tracks, [:name, :artist_id], unique: true
  end
end
