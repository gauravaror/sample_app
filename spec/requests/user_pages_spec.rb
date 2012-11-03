require 'spec_helper'

describe "UserPages" do
let(:base_text) { "Ruby on Rails Tutorial Sample App"}

  describe "signup page" do
    before {visit signup_path}
  subject {page}
  
    it {should have_selector('h1', text: 'Sign up') }
    it {should have_selector('title', text: "#{base_text} | Sign up") }
end
end

 describe "Profile Page" do
  user = User.new(name: "Gaurav",email: "hkdj@kjdkl.com",password: "foobar",password_confirmation: "foobar");
  user.save
  user_new = User.find_by_email("hkdj@kjdkl.com") 
  subject {page} 
  before{visit user_path(user_new)}
  it {should have_selector('h1',text: user.name)}
  it {should have_selector('title',text: user.name)}
 end

  describe "signup" do
    before {visit signup_path}
    let(:submit) {"Create my account"}

    describe "Just Clicking button without information" do
      it "hould not create" do
        expect {click_button submit}.not_to change(User,:count)
       end
    end

    describe "with valid information" do
        before do
          fill_in "Name", with: "Mr. Arora"
          fill_in "Email", with: "kushal18@gmail.com"
          fill_in "Password", with: "foobar"
          fill_in "Confirmation", with: "foobar"
        end
      it "Should create the user" do
        expect {click_button submit}.to change(User,:count).by(1)
      end
    end

  end

