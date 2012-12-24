class MainController < ApplicationController

  before_filter :load_scope

  def index
    @perps = @scope.active_reports.all
  end

  def load_scope
    @scope = Perpetrator
  end
end
