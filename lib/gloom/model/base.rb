# frozen_string_literal: true

module Gloom
  module Model
    module Base
      extend ActiveSupport::Concern

      included do
        attr_reader :context, :initialized_at
      end

      def initialize(options = {})
        @initialized_at = DateTime.now
        @context        = OpenStruct.new(options[:context] || {})
      end
    end
  end
end
