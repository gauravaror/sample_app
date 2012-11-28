require 'spec_helper'

describe Micropost do
  let(:user) {FactoryGirl.create(:user)}
  before {  @micropost = user.microposts.build(content: "Lumsum ") }
  subject {@micropost}


  it { should respond_to(:content)}
  it { should respond_to(:user_id)}
  it { should respond_to(:user) }
  its(:user) { should == user }

  describe "Micropost Association" do

    before { @user.save }  
    let!(:older_micropost) do
      FactoryGirl.create(:micropost,user: @user,created_at: 1.day.ago) 
    end
  
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost,user: @user,created_at: 1.hour.ago)
    end

    it "should have the correct order of the" do
      @user.microposts.should == [newer_micropost,older_micropost]
    end
  end

  describe "accessible attributes" do
    it "should not allow access to used_id" do
      expect do
        Micropost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

end
