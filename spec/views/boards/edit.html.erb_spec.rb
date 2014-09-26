require 'spec_helper'

describe "boards/edit" do
  before(:each) do
    @board = assign(:board, stub_model(Board,
      :year => 1,
      :game_id => 1,
      :user_id => 1
    ))
  end

  it "renders the edit board form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => boards_path(@board), :method => "post" do
      assert_select "input#board_year", :name => "board[year]"
      assert_select "input#board_game_id", :name => "board[game_id]"
      assert_select "input#board_user_id", :name => "board[user_id]"
    end
  end
end
