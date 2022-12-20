# frozen_string_literal: true

module Gloom
  module Model
    module Attributes
      extend ActiveSupport::Concern

      included do
        mattr_accessor :_columns, instance_writer: false, instance_reader: false
      end

      class_methods do
        def column_names
          columns.keys
        end

        def columns
          self._columns ||= {}
        end

        protected

        def column(column_name, options = {})
          self._columns = columns.merge(column_name.to_sym => options)
        end
      end
    end
  end
end
