require 'spec_helper'

describe "AuthenticationPages" do

FactoryGirl.define do
    factory :user do
        name 'Adam Adverti'
        email 'a@b.co'
        password 'fgfwww'
        password_confirmation 'fgfwww'
    end 
end
  
  describe "Signin Page" do
    subject{page}
    before{ visit signin_path}
    it { should have_selector('h1', text: 'Sign in') }
    it { should have_selector('title',text: 'Sign in') }
  end

  describe "visit users path" do
    before{visit users_path}
    subject{page}
      it { should have_selector('h1',text: 'Sign in') }
    end
  
  describe "Invalid data in signin form" do
    subject {page}
    before { visit signin_path}
    before {click_button "Sign in"}
    it { should have_selector('title',text: 'Sign in') }
    it {should have_selector('div.alert.alert-error', text: 'Invalid') }
    end 

  describe "With Valid information" do
    before {visit signin_path}
    let(:user) {FactoryGirl.create(:user) } 
    before do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
    end
    before { visit edit_user_path(user) }
    subject {page}
    it { should have_selector('title' , text: user.name) } 
    it { should have_link('Profile', href: user_path(user)) }
    it { should have_link('Settings' , href: edit_user_path(user)) }
    it { should have_link('Sign out' , href: signout_path ) }
    it { should_not have_link('Sign in' , href: signin_path ) }
        describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

    subject {page}
      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
end
