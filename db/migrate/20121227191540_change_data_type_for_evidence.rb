class ChangeDataTypeForEvidence < ActiveRecord::Migration
  def up
    change_column :reports, :evidence, :string
  end

  def down
    change_column :reports, :evidence, :text
  end
end
