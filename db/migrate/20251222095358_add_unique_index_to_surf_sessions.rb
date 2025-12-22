class AddUniqueIndexToSurfSessions < ActiveRecord::Migration[7.2]
  def change
    add_index :surf_sessions, [:user_id, :session_date], unique: true
  end
end
