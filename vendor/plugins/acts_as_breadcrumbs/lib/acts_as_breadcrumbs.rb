# Copyright (c) 2007 Flinn Mueller
# Released under the MIT License.  See the MIT-LICENSE file for more details.

module ActiveRecord #:nodoc:
  module Acts #:nodoc:

    # ActsAsBreadcrumbs - In Hansel & Gretel, Hansel drops breadcrumbs along the trail through 
    # the forrest to find their way back home. Like Hansel, this plugin adds a breadcrumbs trail
    # attribute based on a base attribute.
    module Breadcrumbs
      def self.included(base) # :nodoc:
        base.extend ClassMethods
      end

      module ClassMethods
        # acts_as_breadcrumbs creates a cached trail of breadcrumbs based
        # on acts_as_tree methods, parent and children
        #
        # Options are:
        # * <tt>:attr</tt>: Attribute name for your breadcrumbs attribute, defaults to :breadcrumbs
        # * <tt>:basename</tt>: Basename attribute to build the breadcrumbs trail, defaults to :name
        # * <tt>:separator</tt>: Set a separator string, defaults to ":"
        # * <tt>:include_root</tt>: Include the root Boolean,
        #
        # Examples:
        #
        # class WebPage < ActiveRecord::Base
        #   acts_as_breadcrumbs(:attr => :url, :basename => :slug, :separator => "/")
        #   acts_as_breadcrumbs(:basename => :title, :separator => "&nbsp;&gt;&nbsp;")
        # end
        #
        # web_page.urls        #=> "foo/bar/baz"
        # web_page.breadcrumbs #=> "Foo&nbsp;&gt;&nbsp;Bar&nbsp;&gt;&nbsp;Baz" # "Foo > Bar > Baz"
        #
        # class Location < ActiveRecord::Base
        #   acts_as_breadcrumbs(:attr => :location_string)
        # end
        #
        # location.location_string #=> "HQ:FL01:RM03"
        #
        # class Soldier < ActiveRecord::Base
        #   acts_as_breadcrumbs(:attr => :chain_o_command, :separator => " > ")
        # end
        #
        # soldier.chain_o_command #=> "General Hailstone > Colonel Stanley > LTC Mueller"
        #
        def acts_as_breadcrumbs(options = {})
          breadcrumbs_attr = options.delete(:attr) || :breadcrumbs
          breadcrumbs_basename = options.delete(:basename) || :name
          breadcrumbs_separator = options.delete(:separator) || ":"
          breadcrumbs_include_root = options.include?(:include_root) ? options.delete(:include_root) : true

          # Creates a breadcrumb string based on an acts_as_tree model
          create = "
            def create_breadcrumb_#{breadcrumbs_attr}
              trail = self.ancestors.collect(&:#{breadcrumbs_basename})
              trail.reverse!
              trail << self.#{breadcrumbs_basename}
              trail.shift unless #{breadcrumbs_include_root}
              self.#{breadcrumbs_attr} = trail.join(\"#{breadcrumbs_separator}\")
            end
          "

          # Updates all this records's child breadcrumb strings
          # Go through each child, update the breadcrumb,
          # if it's different from the stored breadcrumb then save
          # then do the same of all of it's children
          update = "
            def update_breadcrumb_#{breadcrumbs_attr}
              children.each do |c|
                old_breadcrumbs = c.#{breadcrumbs_attr}
                c.create_breadcrumb_#{breadcrumbs_attr}
                c.save unless old_breadcrumbs == c.#{breadcrumbs_attr}
                c.update_breadcrumb_#{breadcrumbs_attr}
              end
            end
          "

          save_callbacks = "
            before_save :create_breadcrumb_#{breadcrumbs_attr}
            after_save :update_breadcrumb_#{breadcrumbs_attr}
          "

          self.class_eval(create)
          self.class_eval(update)
          self.class_eval(save_callbacks)
        end

      end
    end
  end
end