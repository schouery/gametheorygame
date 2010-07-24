module TwoPlayerMatrixGamesHelper
  def payoff_fields(form)
    form.fields_for(:payoffs, TwoPlayerMatrixGamePayoff.new, :child_index => "new_payoff") do |builder|  
      render("payoff_fields", :f => builder)
    end
  end

  def strategy_fields(form)
    form.fields_for(:strategies,TwoPlayerMatrixGameStrategy.new, :child_index => "new_strategy") do |builder|
      render("strategy_fields", :f => builder)
    end
  end
  
  def link_to_add_column(form)  
    link_to_function("Add", h("add_column(this, \"#{escape_javascript(strategy_fields(form))}\", \"#{escape_javascript(payoff_fields(form))}\")"))  
  end

  def link_to_add_line(form)  
    link_to_function("Add", h("add_line(this, \"#{escape_javascript(strategy_fields(form))}\", \"#{escape_javascript(payoff_fields(form))}\")"))  
  end
end
