require 'spec_helper'

describe "boards/new" do
  before(:each) do
    assign(:board, stub_model(Board,
      :year => 1,
      :game_id => 1,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new board form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => boards_path, :method => "post" do
      assert_select "input#board_year", :name => "board[year]"
      assert_select "input#board_game_id", :name => "board[game_id]"
      assert_select "input#board_user_id", :name => "board[user_id]"
    end
  end
end
