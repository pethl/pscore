require 'spec_helper'

describe "predicts/new" do
  before(:each) do
    assign(:predict, stub_model(Predict,
      :user_id => 1,
      :homescore => 1,
      :awayscore => 1,
      :points => 1
    ).as_new_record)
  end

  it "renders new predict form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => predicts_path, :method => "post" do
      assert_select "input#predict_user_id", :name => "predict[user_id]"
      assert_select "input#predict_homescore", :name => "predict[homescore]"
      assert_select "input#predict_awayscore", :name => "predict[awayscore]"
      assert_select "input#predict_points", :name => "predict[points]"
    end
  end
end
