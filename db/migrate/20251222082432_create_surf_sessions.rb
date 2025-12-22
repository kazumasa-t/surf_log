class CreateSurfSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :surf_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.date :session_date
      t.integer :duration_minutes
      t.text :note

      t.timestamps
    end
  end
end
