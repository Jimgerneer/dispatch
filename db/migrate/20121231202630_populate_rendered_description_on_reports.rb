class PopulateRenderedDescriptionOnReports < ActiveRecord::Migration
  def up
    count = Report.all.inject(0) {|sum, obj| sum += 1 if obj.save }
    p "Successfully populated #{count} records"
  end

  def down
    p 'no op'
  end
end
