# frozen_string_literal: true

module Gloom
  module Import
    module Base
      extend ActiveSupport::Concern

      included do
        attr_reader :source_row, :internal_errors
      end

      def initialize(source_row = [], options = {})
        @source_row = source_row

        @internal_errors = ActiveModel::Errors.new(self)

        super(options)
      end
    end
  end
end
