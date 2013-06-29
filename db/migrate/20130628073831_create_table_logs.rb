class CreateTableLogs < ActiveRecord::Migration
  def up
			create_table 	:logs do |t|
			t.string 		:entry
			t.timestamp	:timestamp
			t.string		:environment
			t.integer		:error_status
			t.boolean		:github_issued
			t.boolean		:closed
			t.timestamp :updated
			t.string    :ip_address
		end

		add_index :logs, [:timestamp, :environment, :error_status], unique: true, :name => 'logs_index'
  end

  def down
  end
end
