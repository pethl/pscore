require 'spec_helper'

describe "matches/show" do
  before(:each) do
    @matche = assign(:matche, stub_model(Matche))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
