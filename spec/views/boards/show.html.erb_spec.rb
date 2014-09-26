require 'spec_helper'

describe "boards/show" do
  before(:each) do
    @board = assign(:board, stub_model(Board,
      :year => 1,
      :game_id => 2,
      :user_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
