Given /^a user visit the signin page$/ do
  visit signin_path
end

When /^he submit invalid signin information$/ do
  click_button 'Sign in'
end

Then /^he should see an error message$/ do
  page.should have_selector('div.alert.alert-error')
end

Given /^he has an account$/ do
  @user = User.create(name: 'Kushal Arora',email: 'kushal18@gmail.com',password: 'foobar',password_confirmation: 'foobar')
end

When /^he submit a valid signin information$/ do
  fill_in "Email", with: @user.email
  fill_in "Password" , with: @user.password
  click_button "Sign in"
end

Then /^he should see his profile page$/ do
  page.should have_selector('title',text: @user.name)
end

Then /^he should see a signout link$/ do
  page.should have_link('Sign out',href: signout_path)
end
