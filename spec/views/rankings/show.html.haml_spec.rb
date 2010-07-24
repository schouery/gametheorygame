require 'spec_helper'

describe "/rankings/show.html.haml" do

  before(:each) do
    assigns[:game] = stub_model(TwoPlayerMatrixGame, :name => "Game")
    assigns[:game_scores] = [
      stub_model(GameScore, :score => 10, :user => stub_model(User, :facebook_id => 1)),
      stub_model(GameScore, :score => 5,  :user => stub_model(User, :facebook_id => 2)),
      stub_model(GameScore, :score => -2, :user => stub_model(User, :facebook_id => 3))]
  end

  it "renders the users and their score" do
    render
    response.should contain("Game")
    response.body.should =~ /<fb:name capitalize='true' linked='false' uid='1'><\/fb:name>/
    response.should have_text(/10/)
    response.body.should =~ /<fb:name capitalize='true' linked='false' uid='2'><\/fb:name>/
    response.should have_text(/5/)
    response.body.should =~ /<fb:name capitalize='true' linked='false' uid='3'><\/fb:name>/
    response.should have_text(/-2/)
  end

end