class CreateLimitIpPaths < ActiveRecord::Migration[6.1]
  def change
    create_table :limit_ip_paths do |t|
      t.string :ip
      t.string :path
      t.integer :max_requests_hour
      t.integer :max_requests_day

      t.timestamps
    end
  end
end
