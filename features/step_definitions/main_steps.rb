Given /^I am on the index page$/ do
  visit '/'
end

Given /^I file a report against a player$/ do
  click_link 'create-report'
  fill_in('Evidence', with: 'He attacked my house here, see?')
  fill_in('Location', with: 'Aristopolis')
  fill_in('Time', with: '9:00pm')
  fill_in('Bounty', with: '1')
  select('not listed')
  fill_in('New Perpetrator', with: 'SallyMae')

  click_button 'Create Report'
end

Given /^I open that player's case$/ do
  click_link 'Reports on file'
end

Then /^I should see that report$/ do
  result = page.has_content?('He attacked my house here, see?')
  assert_equal true, result
end

Then /^I should see a case for that player$/ do
  result = page.has_content?('Case: SallyMae')
  assert_equal true, result
end
