#Helper for TwoPlayerMatrixGame's Views
module TwoPlayerMatrixGamesHelper
  #Used to add a column to the matrix of strategies and payoffs, based on
  #http://asciicasts.com/episodes/197-nested-model-form-part-2
  def link_to_add_column(form)  
    link_to_function("Add",
      h("add_column(this, \"#{escape_javascript(strategy_fields(form))}\", \"#{escape_javascript(payoff_fields(form))}\")"))
  end

  #Used to add a line to the matrix of strategies and payoffs, based on
  #http://asciicasts.com/episodes/197-nested-model-form-part-2
  def link_to_add_line(form)  
    link_to_function("Add",
      h("add_line(this, \"#{escape_javascript(strategy_fields(form))}\", \"#{escape_javascript(payoff_fields(form))}\")"))
  end

  private
  #Generates form fields for a TwoPlayerMatrixGamePayoff
  def payoff_fields(form)
    form.fields_for(:payoffs, TwoPlayerMatrixGamePayoff.new,
      :child_index => "new_payoff") do |builder|
      render("payoff_fields", :f => builder)
    end
  end

  #Generates form fields for a TwoPlayerMatrixGameStrategy
  def strategy_fields(form)
    form.fields_for(:strategies,TwoPlayerMatrixGameStrategy.new,
      :child_index => "new_strategy") do |builder|
      render("strategy_fields", :f => builder)
    end
  end
end
