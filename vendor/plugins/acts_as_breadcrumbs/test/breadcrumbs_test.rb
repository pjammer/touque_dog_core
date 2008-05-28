require File.join(File.dirname(__FILE__), 'test_helper')

class Node < ActiveRecord::Base
  acts_as_tree  # need this
  acts_as_breadcrumbs
end

class Location < ActiveRecord::Base
  acts_as_tree  # need this
  acts_as_breadcrumbs(:attr => :location_string)
end

class Soldier < ActiveRecord::Base
  acts_as_tree  # need this
  acts_as_breadcrumbs(:attr => :chain_o_command, :separator => " > ", :include_root => false)
end

class WebPage < ActiveRecord::Base
  acts_as_tree  # need this
  acts_as_breadcrumbs(:attr => :url, :basename => :slug, :separator => "/")
  acts_as_breadcrumbs(:basename => :title, :separator => "&nbsp;&gt;&nbsp;")
end

class BreadcrumbsTest < Test::Unit::TestCase
  fixtures :nodes, :locations, :soldiers, :web_pages

  def test_no_options
    nodes(:node_3).save
    assert_equal "Root:Level 1:Level 2", nodes(:node_3).breadcrumbs    
  end

  def test_alternate_attribute
    locations(:location_3).save
    assert_equal "HQ:FL01:RM03", locations(:location_3).location_string
  end

  def test_basename
    web_pages(:web_page_3).save
    assert_equal "foo/bar/baz", web_pages(:web_page_3).url
  end

  def test_separator
    soldiers(:soldier_4).save
    assert_equal "General Hailstone > Colonel Stanley > LTC Mueller", soldiers(:soldier_4).chain_o_command
  end

  def test_include_root
    locations(:location_1).save
    assert_equal "HQ", locations(:location_1).location_string    
  end

  def test_not_include_root
    soldiers(:soldier_1).save
    assert_equal "", soldiers(:soldier_1).chain_o_command
  end

  def test_two_breadcrumbs
    web_pages(:web_page_3).save
    assert_equal "foo/bar/baz", web_pages(:web_page_3).url
    assert_equal "Foo&nbsp;&gt;&nbsp;Bar&nbsp;&gt;&nbsp;Baz", web_pages(:web_page_3).breadcrumbs
  end
end