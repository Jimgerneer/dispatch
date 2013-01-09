class SessionsController < ApplicationController

  def new
    redirect_url = oauth_client.auth_code.authorize_url(scope: "identity", state: 23456, response_type: 'code', redirect_uri: sessions_url)
    redirect_to redirect_url
  end

  def show
    self.delete
  end

  def create
    code = params[:code]
    if code
      http = Faraday.new(url: "https://oauth.reddit.com")
      http.basic_auth(ENV['REDDIT_KEY'], ENV['REDDIT_SECRET'])
      raw_response = http.post "/api/v1/access_token" do |req|
        req.body = {grant_type: "authorization_code", code: code, client_id: ENV['REDDIT_KEY'], client_secret: ENV['REDDIT_SECRET'], redirect_uri: sessions_url}
      end
      access_token = JSON.parse(raw_response.body)["access_token"]
      token_client = OAuth2::AccessToken.new(oauth_client2, access_token)
      identity_response = token_client.get("https://oauth.reddit.com/api/v1/me")
      #parse body of response form JSON to hash
      identity_response_body = JSON.parse(identity_response.body)
      #pull username out of identity_response
      username = identity_response_body['name']
      #find_or_create_by_username
      user = User.find_or_create_by_username(username)
      #set current user
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash[:error] = "Failed to Authenticate, is Reddit working?"
    end
  end

  def delete
    session[:user_id] = nil
    redirect_to '/'
  end

  protected

  def oauth_client
    @client ||= OAuth2::Client.new(ENV['REDDIT_KEY'],
                                   ENV['REDDIT_SECRET'],
                                   :site => 'https://ssl.reddit.com/',
                                   :authorize_url => '/api/v1/authorize',
                                   :token_url => 'https://oauth.reddit.com/api/v1/access_token',
                                   :scope => 'identity')
  end

  def oauth_client2
    @client2 ||= OAuth2::Client.new(ENV['REDDIT_KEY'],
                                   ENV['REDDIT_SECRET'],
                                   :site => 'https://oauth.reddit.com/',
                                   :state => 23456,
                                   :response_type => 'json',
                                   :authorize_url => '/api/v1/authorize',
                                   :token_url => 'https://oauth.reddit.com/api/v1/access_token',
                                   :scope => 'identity')
  end
end
