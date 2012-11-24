require 'spec_helper'

describe "AuthenticationPages" do
  
  describe "Signin Page" do
    subject{page}
    before{ visit signin_path}
    it { should have_selector('h1', text: 'Sign in') }
    it { should have_selector('title',text: 'Sign in') }
  end
  
  describe "Invalid data in signin form" do
    subject {page}
    before { visit signin_path}
    before {click_button "Sign in"}
    it { should have_selector('title',text: 'Sign in') }
    it {should have_selector('div.alert.alert-error', text: 'Invalid') }
    end 

  describe "With Valid information" do
    subject {page}
    before {visit signin_path}
    let(:user) {FactoryGirl.create(:user) } 
    before do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
    end
    it { should have_selector('title' , text: user.name) } 
    it { should have_link('Profile',href: user_path(user) }
    it { should have_link ('Sign out',href: signout_path) }
    it { should_not have_link ('Sign in',href: signin_path) }

  end
end