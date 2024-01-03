class CreateScrobbles < ActiveRecord::Migration[7.1]
  def change
    create_table :scrobbles do |t|
      t.references :user, null: false, foreign_key: true, type: :string
      t.references :artist, null: false, foreign_key: true
      t.references :album, null: false, foreign_key: true
      t.references :track, null: false, foreign_key: true
      t.time :scrobbled_at

      t.timestamps
    end
    add_index :scrobbles, :scrobbled_at
  end
end
