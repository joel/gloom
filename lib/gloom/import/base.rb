# frozen_string_literal: true

module Gloom
  module Import
    module Base
      extend ActiveSupport::Concern

      included do
        attr_reader :source_row
      end

      def initialize(source_row = [], options = {})
        @source_row = source_row

        super(options)
      end
    end
  end
end
