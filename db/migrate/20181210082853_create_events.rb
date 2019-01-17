class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :date
      t.integer :creator_id
      t.string :venue

      t.timestamps
    end
    add_index :events, :creator_id
  end
end
