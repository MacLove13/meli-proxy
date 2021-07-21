class CreateProxyControls < ActiveRecord::Migration[6.1]
  def change
    create_table :proxy_controls do |t|
      t.integer :max_ip_requests_hour
      t.integer :max_ip_requests_day
      t.integer :max_path_requests_day
      t.integer :max_path_requests_hour

      t.timestamps
    end
  end
end
