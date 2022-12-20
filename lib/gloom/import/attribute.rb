# frozen_string_literal: true

require "gloom/import/attribute_base"

module Gloom
  module Import
    class Attribute < Gloom::AttributeBase
      attr_reader :source_value, :attribute_errors

      def initialize(column_name, source_value, attribute_errors, row_model)
        @source_value     = source_value
        @attribute_errors = attribute_errors

        super(column_name, row_model)
      end

      def value
        @value ||= if attribute_errors.present?
                     nil
                   else
                     source_value
                   end
      end
    end
  end
end
