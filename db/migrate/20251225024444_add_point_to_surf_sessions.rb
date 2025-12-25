class AddPointToSurfSessions < ActiveRecord::Migration[7.2]
  def change
    add_reference :surf_sessions, :point, foreign_key: true
  end
end
