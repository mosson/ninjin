class UpdateColumnName < ActiveRecord::Migration
  def up
  	rename_column(:logs, :closed, :is_closed)
  	rename_column(:logs, :github_issued, :is_issued)
  	rename_column(:logs, :updated, :is_updated)
  	rename_column(:logs, :timestamp, :occurred_date)
  end

  def down
  end
end
