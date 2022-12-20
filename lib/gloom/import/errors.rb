# frozen_string_literal: true

module Gloom
  module Import
    class Errors
      attr_reader :name, :errors

      def initialize(name, errors)
        @name = name
        @errors = errors
      end

      def full_messages
        errors.uniq.map { |error| "#{name.capitalize} #{error}" }
      end
    end
  end
end
