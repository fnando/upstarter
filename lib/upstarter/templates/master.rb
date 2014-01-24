module Upstarter
  module Templates
    class Master < Base
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def export_to(dir)
        create_file "#{options.name}.conf", render(:master), dir
      end
    end
  end
end
