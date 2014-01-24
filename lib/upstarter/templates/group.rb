module Upstarter
  module Templates
    class Group < Base
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def export_to(dir)
        create_file "#{options.name}-#{options.process_name}.conf", render(:group), dir
      end
    end
  end
end
