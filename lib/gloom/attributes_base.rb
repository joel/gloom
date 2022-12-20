# frozen_string_literal: true

require "gloom/model/attributes"
require "gloom/proxy"

module Gloom
  module AttributesBase
    extend ActiveSupport::Concern

    include Model::Attributes
    include Proxy

    def original_attribute(column_name)
      attribute_objects[column_name].try(:value)
    end

    protected

    def array_to_block_hash(array, &block)
      array.zip(array.map(&block)).to_h
    end

    class_methods do
      def column(column_name, options = {})
        super
        define_attribute_method(column_name)
      end

      def define_attribute_method(column_name, &block)
        return if method_defined? column_name

        define_proxy_method(column_name, &block)
      end

      def ensure_attribute_method
        column_names.each { |*args| define_attribute_method(*args) }
      end
    end
  end
end
