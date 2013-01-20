class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.belongs_to :claim
      t.belongs_to :report
      t.string :key

      t.timestamps
    end
    add_index :rewards, :claim_id
    add_index :rewards, :report_id
  end
end
