class InsertInitialPoints < ActiveRecord::Migration[7.2]
  def up
    [
      "木崎浜",
      "加江田",
      "GAP",
      "青島",
      "恋ヶ浦",
      "金ヶ浜"
    ].each do |name|
      Point.find_or_create_by!(name: name)
    end
  end

  def down
    Point.where(name: [
      "木崎浜",
      "加江田",
      "GAP",
      "青島",
      "恋ヶ浦",
      "金ヶ浜"
    ]).delete_all
  end
end
