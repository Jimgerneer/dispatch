class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.text :evidence
      t.string :location
      t.string :time

      t.timestamps
    end
  end
end
