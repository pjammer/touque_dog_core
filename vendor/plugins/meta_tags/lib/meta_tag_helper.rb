module MetaTagHelper
      
  # Renders a meta tag for use in the HEAD section of an html document.
  def meta_tag(name, value, http_equiv = false)
    return nil if value.blank?
    http_equiv = true if %w{expires pragma content-type content-script-type content-style-type default-style content-language refresh window-target cache-control vary}.include? name
    return tag(:meta, :name => name, :content => value) unless http_equiv
    tag :meta, :"http-equiv" => name, :content => value
  end

  # Renders an xhtml doctype declaration for the document's prolog. Defaults to xhtml transitional.
  #
  # <tt>xhtml_doctype :strict</tt>
  def xhtml_doctype( doctype=:transitional )
    doctype = :transitional unless [:transitional, :strict, :frameset].include? doctype
    %(<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 #{doctype.to_s.capitalize}//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-#{doctype.to_s}.dtd">)
  end

  # Displays an html tag, complete with xhtml namespace and language. Accepts language as an option, but defaults to English.
  #
  # <tt>html_tag :lang => 'de'</tt>
  def html_tag( options={} )
    options[:lang] ||= 'en'
    options[:"xml:lang"] = options[:lang]
    options[:xmlns] ||= 'http://www.w3.org/1999/xhtml'
    tag :html, options, true
  end

  # Closing html tag.
  def end_html_tag; "</html>" end
  
end
