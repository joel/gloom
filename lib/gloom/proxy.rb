# frozen_string_literal: true

module Gloom
  module Proxy
    extend ActiveSupport::Concern

    class_methods do
      def proxy
        @proxy ||= Module.new.tap { |mod| include mod }
      end

      def define_proxy_method(*args, &)
        proxy.send(:define_method, *args, &)
      end
    end
  end
end
