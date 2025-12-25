class CreatePoints < ActiveRecord::Migration[7.2]
  def change
    create_table :points do |t|
      t.string :name

      t.timestamps
    end
  end
end
