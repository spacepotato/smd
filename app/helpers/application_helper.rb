module ApplicationHelper

def my_button_to name, options = {}, html_options = {} # or some variation
  # eg. deal with options hash the way button_to deals with it here?
  content_tag :button, html_options = nil do
  	raw name
  end
end

def include_javascript (file)
    s = " <script type=\"text/javascript\">" + render(:file => file) + "</script>"
    content_for(:head, raw(s))
end

end
