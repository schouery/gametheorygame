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
    @options_for_selector[:import_external_friends] = 'false'
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
  
  def canvas_url_for(options = {})
    "http://apps.facebook.com/" + FACEBOOKER['canvas_page_name'] + url_for(options)
  end

  def link_to(name, options = {}, html_options = {})
    html_options[:href] = canvas_url_for(options)
    html_options[:target] = "_top"
    super(name, options, html_options)
  end    
end
