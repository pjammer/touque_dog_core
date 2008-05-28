# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
include TagsHelper
include AdvertsHelper

  def random_string
    char = ("a".."z").to_a + ("1".."9").to_a
    Array.new(6, '').collect{char[rand(char.size)]}.join
  end
  
  def meta_tagged
     content_for :seo_meta_keywords do
     @kw = []
     @posts.each {|x| @kw.concat(x.tag_list) }
     meta_tag('keywords', @kw.uniq.join(", "))
     end
   end
  
  protected
  
  def header_css
    if current_controller == 'headers' && %w(edit show).include?(current_action)
      @header = Header.find(params[:id])
    else
      @header = Header.random
    end
    return '<style type="text/css">.header { background: #333 url("' + @header.public_filename + '") !important; }</style>' if @header
  end
    
  def theme_css
    return '<style type="text/css">@import "/stylesheets/application.css";</style>' if @settings.theme.nil? 
    return '<style type="text/css">@import "/themes/' + @settings.theme + '";</style>'
  end

  def page_title
    page_title = h(@settings.title) unless @settings.nil?
    page_title << ': ' + @category.to_s unless @category.nil? or @category.name.nil?
    page_title << ': ' + @event.to_s unless @event.nil? or @event.title.nil?
    page_title << ': ' + @forum.to_s unless @forum.nil? or @forum.name.nil?
    page_title << ': ' + @header.to_s unless @header.nil? or @header.filename.nil?
    page_title << ': ' + @topic.to_s unless @topic.nil? or @topic.title.nil?
    page_title << ': ' + @user.to_s unless @user.nil? or @user.login.nil?
    return page_title
  end
  
  def avatar_for(user)
    image_tag user.avatar unless user.avatar.nil?
  end
  
  def rank_for(user)
    return 'Administrator' if user.admin
    @ranks ||=  Rank.find(:all, :order => "min_posts")
    return "Member" if @ranks.blank?
    for r in @ranks
      @rank = r if user.posts_count >= r.min_posts
    end
    return h(@rank.title)
  end
  
  def tab(name)
    if name == current_controller
      'current_tab'
    elsif name == "forums" && %w(categories topics posts).include?(current_controller)
      'current_tab'
    elsif name == "users" && ((current_controller == "avatars"))
      'current_tab'
    end
  end
  
  def is_new?(item)
    return false unless logged_in?
    return true if session[:online_at] < item.updated_at
  end
  
  def icon_for(item)
    return '<div class="icon"><!-- --></div>' if item.nil?
    return '<div class="icon inew"><!-- --></div>' if is_new?(item)
    return '<div class="icon"><!-- --></div>'
  end
    
  def bb(text)
    text = simple_format(bbcodeize(sanitize(h(text))))
    auto_link(text) do |t|
      truncate(t, 50)
    end
  end
    
  def tz(time_at)
    time_stamp(TzTime.zone.utc_to_local(time_at.utc))
  end
  
  def tz_today?(time)
    return true if TzTime.now.strftime('%Y-%m-%d') == TzTime.zone.utc_to_local(time.utc).strftime('%Y-%m-%d')
  end

  def current_page(collection)
    'Page ' + collection.current_page.to_s + ' of ' + collection.page_count.to_s
  end

  def prev_page(collection)
    unless collection.current_page == 1 or collection.page_count == 0
      link_to('&laquo; Previous page', { :page => collection.previous_page }.merge(params.reject{|k,v| k=='page'}))
    end
  end
  
  def next_page(collection)
    unless collection.current_page == collection.page_count or collection.page_count == 0
      link_to('Next page &raquo;', { :page => collection.next_page }.merge(params.reject{|k,v| k=='page'}))
    end
  end
  
  def current_controller
    request.path_parameters['controller']
  end
  
  def current_action
    request.path_parameters['action']
  end
  
  def time_ago_or_time_stamp(from_time, to_time = TzTime.now, include_seconds = true, detail = false)
    from_time = TzTime.zone.utc_to_local(from_time)
    from_time = from_time.to_time if from_time.respond_to?(:to_time)
    to_time = to_time.to_time if to_time.respond_to?(:to_time)
    distance_in_minutes = (((to_time - from_time).abs)/60).round
    distance_in_seconds = ((to_time - from_time).abs).round
    case distance_in_minutes
      when 0..1           then time = (distance_in_seconds < 60) ? "#{pluralize(distance_in_seconds, 'second')} ago" : '1 minute ago'
      when 2..59          then time = "#{distance_in_minutes} minutes ago"
      when 60..90         then time = "1 hour ago"
      when 90..1440       then time = "#{(distance_in_minutes.to_f / 60.0).round} hours ago"
      when 1440..2160     then time = '1 day ago' # 1 day to 1.5 days
      when 2160..2880     then time = "#{(distance_in_minutes.to_f / 1440.0).round} days ago" # 1.5 days to 2 days
      else time = from_time.strftime("%a, %d %b %Y")
    end
    return time_stamp(from_time) if (detail && distance_in_minutes > 2880)
    return time
  end
  
  def time_stamp(time)
    time.to_datetime.strftime("%a, %d %b %Y, %l:%M%P").squeeze(' ')  
  end
  #Allows only current user or a friend of current user to view the page.
  def me_or_friend?
    if logged_in?
    current_user.is_friends_with? @user or @user == current_user
    else
    
    flash[:notice] = "You Aren't allowed to view that page.s"
  end
end
#a helper used in the menu of your site, to distinguish between a logged in user and a guest.  Navigate them to where you want, DRY.
def nav_link(linkname1, logged_in_path, linkname2, nonlogged_path)
  if logged_in?
	link_to linkname1, logged_in_path
	else
	link_to linkname2, nonlogged_path
	end
end
end

