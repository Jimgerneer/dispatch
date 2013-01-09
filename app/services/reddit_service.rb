require 'cgi'

class RedditService

  def self.case_submit_link(perpetrator, user=nil)
    if user == nil
     title = "[Pearled] #{perpetrator.name} pearled, post claims"
    else
     title = "[Pearled] #{perpetrator.name} pearled by #{user.username} post claims"
    end
     text = %Q{
##CivBounty Links Below

* Case: Click [here](http://www.civbounty.com/reports/#{perpetrator.id}/perpetrators)

####Additional Comments:


*Thank you for using [CivBounty](http://www.civbounty.com)*
     }

    url = "http://www.reddit.com/r/Civcraft/submit?title=#{CGI.escape(title)}&text=#{CGI.escape(text)}"
  end

  def self.report_submit_link(report, perpetrator, user=nil)
    if user == nil
      if report.bounty > 0
        title = "Wanted: #{perpetrator.name}'s pearl for #{report.bounty}d -CivBounty"
      else
        title = "Report: #{perpetrator.name} -CivBounty"
      end
    else
      if report.bounty > 0
        title = "Wanted: #{perpetrator.name}'s pearl for #{report.bounty}d by #{user.username}"
      else
        title = "Report: Crimes against #{user.username} by #{perpetrator.name}"
      end
    end
     text = %Q{
##CivBounty Links Below

* Report: Click [here](http://www.civbounty.com/reports/#{report.id}) for the report 
* Case: Click [here](http://www.civbounty.com/reports/#{perpetrator.id}/perpetrators)

####Additional Comments:


*Thank you for using [CivBounty](http://www.civbounty.com)*
     }

    url = "http://www.reddit.com/r/Civcraft/submit?title=#{CGI.escape(title)}&text=#{CGI.escape(text)}"
  end

=begin
  def self.post_report(report, token, modhash)
    client = OAuth2::AccessToken.new(oauth_client, token)
    url = "http://www.civbounty.com"
    # /reports/#{report.id}"
    perp = Perpetrator.find(report.perpetrator_id)
    user = User.find(report.user_id)
    title = "Bounty of #{report.bounty}d placed on #{perp.name} -CivBounty"
    opts = { kind: 'link', url: url, title: title, sr: 'rook', r: 'rook', uh: modhash}
    reddit_response = client.post("/api/submit", opts)
  end
        #get modhash through hack
        #info_response = token_client.get("https://oauth.reddit.com/api/info")
        #info_response_body = JSON.parse(info_response.body)
        #modhash = info_response_body['data']['modhash']


  def self.oauth_client
    @client ||= OAuth2::Client.new(ENV['REDDIT_KEY'],
                                   ENV['REDDIT_SECRET'],
                                   :site => 'https://oauth.reddit.com/',
                                   :state => 23456)
  end
=end
end
