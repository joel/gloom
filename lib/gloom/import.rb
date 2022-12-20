# frozen_string_literal: true

require "gloom/import/base"
require "gloom/import/attributes"

module Gloom
  module Import
    extend ActiveSupport::Concern

    include ActiveModel::Validations

    include Base
    include Attributes
  end
end
