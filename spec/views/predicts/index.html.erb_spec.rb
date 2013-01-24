require 'spec_helper'

describe "predicts/index" do
  before(:each) do
    assign(:predicts, [
      stub_model(Predict,
        :user_id => 1,
        :homescore => 2,
        :awayscore => 3,
        :points => 4
      ),
      stub_model(Predict,
        :user_id => 1,
        :homescore => 2,
        :awayscore => 3,
        :points => 4
      )
    ])
  end

  it "renders a list of predicts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
