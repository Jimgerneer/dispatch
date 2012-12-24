class CreatePerpetrators < ActiveRecord::Migration
  def change
    create_table :perpetrators do |t|
      t.string :name

      t.timestamps
    end
  end
end
