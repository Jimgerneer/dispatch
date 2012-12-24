class Report < ActiveRecord::Base
  attr_accessor :other_wanted

  before_save :set_wanted

  private

  def set_wanted
    if @other_wanted and wanted_id.blank?
      # create a wanted and set our id
    end
  end
end
