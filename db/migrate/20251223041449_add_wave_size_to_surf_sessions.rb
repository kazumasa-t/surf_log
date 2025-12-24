class AddWaveSizeToSurfSessions < ActiveRecord::Migration[7.2]
  def change
    add_column :surf_sessions, :wave_size, :string
  end
end
