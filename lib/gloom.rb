# frozen_string_literal: true

# require "zeitwerk"
# loader = Zeitwerk::Loader.for_gem
# loader.setup

# module Gloom
#   class Error < StandardError; end
# end

require "active_support"
require "active_support/dependencies/autoload"
require "active_support/core_ext/object"
require "active_support/core_ext/string"

require "csv"
require "ostruct"
require "active_model"

require "gloom/model"
require "gloom/import"
