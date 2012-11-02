# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do

  before { @user = User.new(name: "User me",email: "mail@me.com",password: "foobar",password_confirmation: "foobar")}
  subject{@user}
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:authenticate) }
  it { should be_valid }

 describe "when name is not present" do
  before {@user.name = ""}
  it {should_not be_valid}
 end

 describe "when email is not present" do
  before {@user.email = ""}
  it {should_not be_valid}
 end

 describe "when name is too  long" do
  before {@user.name = "a"*51}
  it {should_not be_valid}
 end

 describe "when email id is valid" do
  it "should be valid" do
  emai  = %w[foo.bar@foo.com foo@foo.com.bar zoo@soo.com]
  emai.each do |i|
   @user.email = i
   should be_valid
  end
end
end
 
describe "when email id is invalid" do
  it "should be invalid" do
  emai  = %w[foo.bar@foo foofoo.com.bar @soocom]
  emai.each do |i|
   @user.email = i
    @user.should_not be_valid
  end
  end
 end

 describe "When email addess is already taken by someone" do
  before do
    user_name_duplicate = @user.dup
    user_name_duplicate.save
  end
  it {should_not be_valid}
 end
 
 describe "when password is not present" do
  before {@user.password = @user.password_confirmation = " " }
  it {should_not be_valid}
 end

 describe "when password doesnt match confirmation" do
  before {@user.password_confirmation = "mistmatch"}
  it {should_not be_valid}
 end

describe "when password confirmation is nil" do
  before { @user.password_confirmation = nil }
  it { should_not be_valid }
end

 describe "return value of authenticate method" do
  before {@user.save}
  let(:found_user) { User.find_by_email(@user.email) }
  
  describe "with valid password" do
    it { should == found_user.authenticate(@user.password) }
  end
  
  describe "with invalid password" do
    let(:user_for_invalid_password) { found_user.authenticate("invalid") }
    it {should_not == user_for_invalid_password  }
    
  end

  describe "with a password thats too short" do
    before { @user.password = @user.password_confirmation = "a"*5 }
    it { should_not be_valid}
  end
end

end

