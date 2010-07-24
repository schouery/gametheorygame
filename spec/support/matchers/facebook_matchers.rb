Spec::Matchers.define :have_multi_friend_selector_with do |options|
  match do |actual|
    exclude = options[:exclude_ids].nil? ? "" : " exclude_ids='#{options[:exclude_ids]}'" 
    expected = "
    <fb:serverfbml.*>
      <script type='text/fbml'>
        <fb:fbml>
          <fb:request-form action='.*#{options[:action]}' content='.*&lt;fb:req-choice label=\".*\" url=\"#{options[:url_for_invite]}\" /&gt;' invite='#{options[:invite?]}' method='post' type='.*'>
            <fb:multi-friend-selector actiontext='.*' condensed='.*' email_invite='.*'#{exclude} import_external_friends='false' max='#{options[:max]}' showborder='.*'></fb:multi-friend-selector>
          </fb:request-form>
        </fb:fbml>
      </script>
    </fb:serverfbml>".gsub(/(\s*<)/m,"<").gsub(/></m,">\\s*<")
    actual =~ Regexp.new(expected, Regexp::MULTILINE)    
  end
end
