class UpdateColumnLimitLength < ActiveRecord::Migration
  def up
  	change_column(:logs, :entry, :string, :limit => 40000)
  end

  def down
  end
end
