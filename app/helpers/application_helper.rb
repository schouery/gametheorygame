# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def xfbml_start
    "<script type='text/javascript'> 
      FB_RequireFeatures([\"XFBML\"], function(){FB.Facebook.init(\"fc078e80530728cee7c1e2630803952f\", \"/xd_receiver.htm\"); });
    </script>"
  end
  
end
