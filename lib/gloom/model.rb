# frozen_string_literal: true

require "gloom/model/base"
require "gloom/model/attributes"

module Gloom
  module Model
    extend ActiveSupport::Concern

    include Base
    include Attributes
  end
end
