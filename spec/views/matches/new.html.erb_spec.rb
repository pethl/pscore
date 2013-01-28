require 'spec_helper'

describe "matches/new" do
  before(:each) do
    assign(:matche, stub_model(Matche).as_new_record)
  end

  it "renders new matche form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => matches_path, :method => "post" do
    end
  end
end
