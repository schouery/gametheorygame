# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def xfbml_start
    "<script type='text/javascript'> 
      FB_RequireFeatures([\"XFBML\"], function(){FB.Facebook.init(\"77fe2d55843774a0faa0d64f2c0212c5\", \"/xd_receiver.htm\"); });
    </script>"
  end
  
  def generate_options_for_friend_selector(options = {})
    options.reverse_merge!(friend_defaults)
    @options_for_request_form = {:action => options[:next_action],
      :content => options[:content] + fb_req_choice(options[:button], options[:path_for_invitation]),
      :invite => 'true',
      :method => 'post',
      :type => options[:button_name]}
    @options_for_selector = {:actiontext => options[:actiontext],
      :condensed => options[:condensed],
      :max => options[:max],
      :showborder=> options[:showborder]}    
  end
  
  def friend_defaults
    @friend_defaults ||= {:showborder => 'true',
                          :button => 'Accept',
                          :condensed => 'false',
                          :max => '20'}    
  end
    
end
