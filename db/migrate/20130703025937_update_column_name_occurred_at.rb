class UpdateColumnNameOccurredAt < ActiveRecord::Migration
  def up
  	rename_column(:logs, :occurred_date, :occurred_at)
  end

  def down
  end
end
