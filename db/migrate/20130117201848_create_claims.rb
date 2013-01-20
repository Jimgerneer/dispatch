class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.belongs_to :hunter
      t.belongs_to :perpetrator
      t.text :description

      t.timestamps
    end
    add_index :claims, :hunter_id
    add_index :claims, :perpetrator_id
  end
end
