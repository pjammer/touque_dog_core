require 'rubygems'
require 'test/unit'
require File.dirname(__FILE__) + '/../lib/meta_tag_helper'
require 'action_view/helpers/tag_helper'

class MetaTagTest < Test::Unit::TestCase

  include ActionView::Helpers::TagHelper
  include MetaTagHelper

  def test_meta_tag
    output = meta_tag('keywords', 'cat, mouse, squirrel')
    assert_equal_with_value_pairs %(<meta content="cat, mouse, squirrel" name="keywords" />), output
    output = meta_tag('content-type', 'text/html', true)
    assert_equal_with_value_pairs %(<meta http-equiv="content-type" content="text/html" />), output
  end

  def test_xhtml_doctype
    assert_match /transitional/, xhtml_doctype
    %w(transitional strict frameset).each do |type|
      assert_match type, xhtml_doctype(type.to_sym)
    end
  end

  def test_html_tag
    assert_match /lang="en"/, html_tag
    assert_match /lang="de"/, html_tag(:lang => 'de')
  end

  def test_end_html_tag
    assert_equal "</html>", end_html_tag
  end
  
  private
  
  def assert_equal_with_value_pairs(expected, actual, message=nil)
    if expected.empty?
      assert_equal expected, actual, message
    else
      pairs_pattern = /(\s+[\w-]+=".+?")+\s*/
      expected_trimmed = expected.sub(pairs_pattern, '')
      expected_pairs = $& ? $&.split(' ').sort : nil;
      actual_trimmed = actual.sub(pairs_pattern, '')
      actual_pairs = $& ? $&.split(' ').sort : nil;
      
      unless expected_pairs && actual_pairs
        assert_equal expected, actual, message
      else
        assert_equal expected_trimmed, actual_trimmed, 'trimmed strings don\'t match'
        assert_equal expected_pairs, actual_pairs, 'key-value pairs differ'
      end
    end
  end
end
