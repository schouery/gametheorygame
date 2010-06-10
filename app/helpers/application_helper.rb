# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def xfbml_start
    "<script type='text/javascript'> 
      FB_RequireFeatures([\"XFBML\"], function(){FB.Facebook.init(\"#{ENV['FACEBOOK_API_KEY']}\", \"/xd_receiver.htm\"); });
    </script>"
  end
  
  def generate_options_for_friend_selector(options = {})
    options.reverse_merge!(friend_defaults)
    @options_for_request_form = {:action => options[:next_action],
      :content => options[:content] + fb_req_choice(options[:button], options[:path_for_invitation]),
      :invite => options[:invite],
      :method => 'post',
      :type => options[:button_name]}
    @options_for_selector = {:actiontext => options[:actiontext],
      :condensed => options[:condensed],
      :max => options[:max],
      :showborder=> options[:showborder],
      :email_invite => options[:email_invite]}
    @options_for_selector[:exclude_ids] = options[:exclude_ids] if !options[:exclude_ids].nil?
  end
  
  def friend_defaults
    @friend_defaults = {:showborder => 'false',
                        :button => 'Accept',
                        :condensed => 'false',
                        :max => '20',
                        :invite => 'true',
                        :email_invite => 'false'
                        }    
  end

  def link_to_add_fields(name, f, association)  
    new_object = f.object.class.reflect_on_association(association).klass.new  
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|  
      render(association.to_s.singularize + "_fields", :f => builder, :last => true)
    end  
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))  
  end

  def link_to_add_column(f)  
    name = "Add"
    new_payoff = TwoPlayerMatrixGamePayoff.new
    new_strategy = TwoPlayerMatrixGameStrategy.new
    payoff_fields = f.fields_for(:payoffs, new_payoff, :child_index => "new_payoff") do |builder|  
      render("payoff_fields", :f => builder)
    end  
    strategy_fields = f.fields_for(:strategies, new_strategy, :child_index => "new_strategy") do |builder|
      render("strategy_fields", :f => builder)
    end  
    link_to_function(name, h("add_column(this, \"#{escape_javascript(strategy_fields)}\", \"#{escape_javascript(payoff_fields)}\")"))  
  end

  def link_to_add_line(f)  
    name = "Add"
    new_payoff = TwoPlayerMatrixGamePayoff.new
    new_strategy = TwoPlayerMatrixGameStrategy.new
    payoff_fields = f.fields_for(:payoffs, new_payoff, :child_index => "new_payoff") do |builder|  
      render("payoff_fields", :f => builder)
    end  
    strategy_fields = f.fields_for(:strategies, new_strategy, :child_index => "new_strategy") do |builder|
      render("strategy_fields", :f => builder)
    end  
    link_to_function(name, h("add_line(this, \"#{escape_javascript(strategy_fields)}\", \"#{escape_javascript(payoff_fields)}\")"))  
  end
  
  def link_to(name, options = {}, html_options = {})
      html_options[:href] = "http://apps.facebook.com/" + FACEBOOKER['canvas_page_name'] + url_for(options)
      html_options[:target] = "_top"      
      super(name, options, html_options)
  end
  
  def canvas_url_for(options = {})
    "http://apps.facebook.com/" + FACEBOOKER['canvas_page_name'] + url_for(options)
  end
  
end
