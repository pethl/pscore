require 'spec_helper'

describe "predicts/show" do
  before(:each) do
    @predict = assign(:predict, stub_model(Predict,
      :user_id => 1,
      :homescore => 2,
      :awayscore => 3,
      :points => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
  end
end
