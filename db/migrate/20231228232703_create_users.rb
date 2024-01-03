class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: false do |t|
      t.string :id, primary_key: true
      t.time :last_cache, default: Time.at(0), null: false
      t.time :last_full_cache, default: Time.at(0), null: false

      t.timestamps
    end
  end
end
