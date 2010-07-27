# Methods added to this helper will be available to all templates in the
# application.
module ApplicationHelper
  #Javascript that starts the XFBML from Facebook
  def xfbml_start
    "<script type='text/javascript'> 
      FB_RequireFeatures([\"XFBML\"], function(){FB.Facebook.init(\"#{ENV['FACEBOOK_API_KEY']}\", \"/xd_receiver.htm\"); });
    </script>"
  end

  #It assigns @options_for_request_form and @options_for_selecot according to
  #options. Is used for configurating the multi-friend-selector.
  def generate_options_for_friend_selector(options = {})
    options.reverse_merge!(multi_friend_selector_defaults)
    @options_for_request_form = {:action => options[:next_action],
      :content => options[:content] +
        fb_req_choice(options[:button], options[:path_for_invitation]),
      :invite => options[:invite],
      :method => 'post',
      :type => options[:button_name]}
    @options_for_selector = {:actiontext => options[:actiontext],
      :condensed => options[:condensed],
      :max => options[:max],
      :showborder=> options[:showborder],
      :email_invite => options[:email_invite]}
    if !options[:exclude_ids].nil?
      @options_for_selector[:exclude_ids] = options[:exclude_ids]
    end
    @options_for_selector[:import_external_friends] = 'false'
  end

  #Returns a URL that points to "http://apps.facebook.com" instead of the local
  #server. It's used because Rails will set the url_for to the local server, not
  #application path on Facebook.
  def canvas_url_for(options = {})
    "http://apps.facebook.com/" + FACEBOOKER['canvas_page_name'] +
      url_for(options)
  end

  #Rewrites link_to to use canvas_url_for and set the target to _top. In this
  #way, links will continue inside Facebook.
  def link_to(name, options = {}, html_options = {})
    html_options[:href] = canvas_url_for(options)
    html_options[:target] = "_top"
    super(name, options, html_options)
  end

  private
  #Defaults for the multi_friend_selector
  def multi_friend_selector_defaults
    {:showborder => 'false',
     :button => 'Accept',
     :condensed => 'false',
     :max => '20',
     :invite => 'true',
     :email_invite => 'false'}
  end
end
