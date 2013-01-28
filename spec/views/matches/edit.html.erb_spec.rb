require 'spec_helper'

describe "matches/edit" do
  before(:each) do
    @matche = assign(:matche, stub_model(Matche))
  end

  it "renders the edit matche form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => matches_path(@matche), :method => "post" do
    end
  end
end
