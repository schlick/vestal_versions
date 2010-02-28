module VestalVersions
  # Provides a way of overriding the default timestamps to allow for handling legacy data
  module Timestamps
    def self.included(base) # :nodoc:
      base.class_eval do
        include InstanceMethods

        attr_accessor :original_timestamp
        alias_method_chain :version_attributes, :timestamp
      end
    end

    # Methods added to versioned ActiveRecord::Base instances to enable versioning with
    # original timestamps.
    module InstanceMethods
      private
        # Overrides the +version_attributes+ method to override default created_at and
        # updated_at with the +original_timestamp+ attr_accessor.
        def version_attributes_with_timestamp
          version_attributes_without_timestamp.merge(:created_at => original_timestamp,
                                                     :updated_at => original_timestamp)
        end
    end
  end
end
