class CreateShareLinks < ActiveRecord::Migration[7.2]
  def change
    create_table :share_links do |t|
      t.references :user, null: false, foreign_key: true
      t.date :month
      t.string :token

      t.timestamps
    end
  end
end
