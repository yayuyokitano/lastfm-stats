# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_28_234905) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string "name"
    t.bigint "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_albums_on_artist_id"
    t.index ["name", "artist_id"], name: "index_albums_on_name_and_artist_id", unique: true
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_artists_on_name", unique: true
  end

  create_table "scrobbles", force: :cascade do |t|
    t.string "user_id", null: false
    t.bigint "artist_id", null: false
    t.bigint "album_id", null: false
    t.bigint "track_id", null: false
    t.time "scrobbled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_scrobbles_on_album_id"
    t.index ["artist_id"], name: "index_scrobbles_on_artist_id"
    t.index ["scrobbled_at"], name: "index_scrobbles_on_scrobbled_at"
    t.index ["track_id"], name: "index_scrobbles_on_track_id"
    t.index ["user_id"], name: "index_scrobbles_on_user_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "name"
    t.bigint "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_tracks_on_artist_id"
    t.index ["name", "artist_id"], name: "index_tracks_on_name_and_artist_id", unique: true
  end

  create_table "users", id: :string, force: :cascade do |t|
    t.time "last_cache", default: "2000-01-01 00:00:00", null: false
    t.time "last_full_cache", default: "2000-01-01 00:00:00", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "albums", "artists"
  add_foreign_key "scrobbles", "albums"
  add_foreign_key "scrobbles", "artists"
  add_foreign_key "scrobbles", "tracks"
  add_foreign_key "scrobbles", "users"
  add_foreign_key "tracks", "artists"
end
