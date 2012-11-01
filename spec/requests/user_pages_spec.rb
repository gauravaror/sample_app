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

