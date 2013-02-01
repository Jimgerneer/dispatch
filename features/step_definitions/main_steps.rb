Given /^The db is seeded$/ do
  @user = User.create(:username => "testtest")
  @report = Report.create(:perpetrator_name => "Frank", 
                          :user_id => @user.id, 
                          :description => "This is information", 
                          :bounty => 0 )
  @perpetrator = Perpetrator.find_by_id(@report.perpetrator_id)
end

Given /^I am on the index page$/ do
  visit '/'
end

Given /^I am signed in$/ do
  @user
  sign_in
end

Given /^I file a report against a player$/ do
  visit '/reports/new'
  fill_in('Location', with: 'Aristopolis')
  fill_in('Description', with: 'He attacked my house here, see?')
  fill_in('Bounty', with: '1')
  fill_in('Perpetrator', with: 'SallyMae')
  fill_in('Civilization', with: 'Gondolin')
  first('#evidence_field').fill_in('Evidence Link', with: 'http://www.civbounty.com')

  click_button 'File Report'
end

Given /^I am on the case page$/ do
  visit "/perpetrators/#{@perpetrator.id}/reports"
end

Given /^I click the "(.*?)" link$/ do |arg1|
  click_link("Claim Capture of #{@perpetrator.name}")
end

Given /^I fill out a claim$/ do
  fill_in("Describe capture", with: "This is a test claim")
end

Given /^a user has claimed capture of my perp$/ do
  @new_user = User.create(username: "numbertwo")
  @claim = Claim.create(hunter_id: @new_user.id, perpetrator_id: @perpetrator.id, description: "Hey this is a test!")
end

Given /^I close my report$/ do
  visit "/user/reports"
  click_link "Close"
end

Given /^I reward them a point$/ do
  first('dl').click_link "Close"
end

Then /^they should be on the leaderboard$/ do
  result = page.has_content?("numbertwo")
  assert_equal true, result
end

Then /^a claim should be filed$/ do
  result = page.has_content?("This is a test claim")
  assert_equal true, result
end

Then /^I should see that report$/ do
  result = page.has_content?('He attacked my house here, see?')
  assert_equal true, result
end

Then /^I should see a case for that player$/ do
  result = page.has_content?('Case: SallyMae')
  assert_equal true, result
end

private

def sign_in
  if Capybara.current_driver == :webkit
    page.driver.browser.set_cookie("stub_user_id=#{@user.id}; path=/; domain=127.0.0.1")
  else
    cookie_jar = Capybara.current_session.driver.browser.current_session.instance_variable_get(:@rack_mock_session).cookie_jar
    cookie_jar [:stub_user_id] = @user.id
  end
end
