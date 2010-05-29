require 'spec_helper'

describe "/symmetric_function_games/statistics.html.haml" do

  before(:each) do
    @strategy1 = stub_model(SymmetricFunctionGameStrategy, :new_record? => true, :label => "Strategy1")
    @strategy2 = stub_model(SymmetricFunctionGameStrategy, :new_record? => true, :label => "Strategy2")    
    assigns[:symmetric_function_game] = @symmetric_function_game = stub_model(
      SymmetricFunctionGame, 
      :name => "Polution Game",
      :strategies_percentages => {@strategy1 => 0, @strategy2 => 0},
      :strategies => [@strategy1, @strategy2]
    )
  end

  it "renders attributes in <p>" do
    render
    response.should contain("Polution Game")
  end
  
  it "should show the strategies percentages if it is all zero" do
    render
    response.should have_tag("table") do
      with_tag("tr[id='0']") do
        with_tag("td[id='0']", 'Strategy1') 
        with_tag("td[id='1']", '0%')
      end
      with_tag("tr[id='1']") do
        with_tag("td[id='0']", 'Strategy2') 
        with_tag("td[id='1']", '0%')
      end
    end    
  end
  
  it "should show the strategies percentages for generic results" do
    @symmetric_function_game.stub(:strategies_percentages => {@strategy1 => 0.3, @strategy2 => 0.7})
    render
    response.should have_tag("table") do
      with_tag("tr[id='0']") do
        with_tag("td[id='0']", 'Strategy1') 
        with_tag("td[id='1']", '30.0%')
      end
      with_tag("tr[id='1']") do
        with_tag("td[id='0']", 'Strategy2') 
        with_tag("td[id='1']", '70.0%')
      end
    end
  end
  
end
