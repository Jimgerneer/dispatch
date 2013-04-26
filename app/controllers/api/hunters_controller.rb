class Api::HuntersController < ApplicationController
  respond_to :json

  def index
    @hunters = User.hunter_leaderboard
    render template: 'api/hunters/index.json.jbuilder'
  end
end
