require 'spec_helper'








describe "UserPages" do
FactoryGirl.define do
    factory :user do
        name 'Adam Advertiser'
        email 'a@b.com'
        password 'fgfgfg'
        password_confirmation 'fgfgfg'
    end 
end
let(:base_text) { "Ruby on Rails Tutorial Sample App"}

  describe "signup page" do
    before {visit signup_path}
  subject {page}
  
    it {should have_selector('h1', text: 'Sign up') }
    it {should have_selector('title', text: "#{base_text} | Sign up") }
  end

  describe "Edit Page" do
    let(:user) {FactoryGirl.create(:user)}
#        before {
 #         visit signup_path
  #        fill_in "Name", with: user.name
   #       fill_in "Email", with: user.email
    #      fill_in "Password", with: user.password
     #     fill_in "Confirmation", with: user.password
      #    click_button 'Create my account'
       # }
        before { visit edit_user_path(user) }
    subject {page}
    describe "page" do
      it { should have_selector('h1',text: "Update your Profile") }
      it { should have_selector('title',text: "#{base_text} | Edit user") }
      it { should have_link('change',href: 'http://gravatar.com/emails') }
    end
  
  describe "with invalid information" do
    before { click_button "Save changes" }
    it { should have_content('Invalid') }
  end
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
      it "should not create" do
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
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          subject {page}
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
        

      describe "as wrong user" do
        let(:user) { FactoryGirl.create(:user) }
        let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
        before do
          visit signin_path
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button 'Sign in'
        end

        describe "visiting Users#edit page" do
          before { visit edit_user_path(wrong_user) }
          it { should_not have_selector('title', text: 'Edit user') }
        end

        describe "submitting a PUT request to the Users#update action" do
          before { put user_path(wrong_user) }
          specify { response.should redirect_to(root_path) }
        end

      end

    end
    end
  end

end
