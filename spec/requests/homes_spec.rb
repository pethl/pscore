require 'spec_helper'

describe "Home page" do # The first line indicates that we are describing the Home page. This description is just a string, and it can be anything you want; RSpec doesn’t care, but you and other human readers probably do. 
  describe "GET /homes" do
    it "works! (now write some real specs)" do
    
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get home_path
      response.status.should be(200)
    end
  end
end
