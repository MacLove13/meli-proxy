class CreateIpHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :ip_histories do |t|
      t.string :ip
      t.string :path

      t.timestamps
    end
  end
end
