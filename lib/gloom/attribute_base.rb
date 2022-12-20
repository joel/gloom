# frozen_string_literal: true

module Gloom
  class AttributeBase
    attr_reader :column_name, :row_model

    def initialize(column_name, row_model)
      @column_name = column_name
      @row_model   = row_model
    end
  end
end
