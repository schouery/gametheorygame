Spec::Matchers.define :have_multi_friend_selector_with do |options|
  match do |actual|
    expected = "
    <fb:serverfbml.*>
      <script type='text/fbml'>
        <fb:fbml>
          <fb:request-form action='.*#{options[:action]}' content='.*&lt;fb:req-choice label=\".*\" url=\"#{options[:url_for_invite]}\" /&gt;' invite='#{options[:invite?]}' method='post' type='.*'>
            <fb:multi-friend-selector actiontext='.*' condensed='.*' max='#{options[:max]}' showborder='.*'></fb:multi-friend-selector>
          </fb:request-form>
        </fb:fbml>
      </script>
    </fb:serverfbml>".gsub(/(\s*<)/m,"<").gsub(/></m,">\\s*<")
    actual =~ Regexp.new(expected, Regexp::MULTILINE)    
  end
end