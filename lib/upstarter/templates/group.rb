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

      def log_dir
        "/var/log/#{options.parent_name}-#{options.process_name}"
      end

      def run_dir
        "/var/run/#{options.parent_name}-#{options.process_name}"
      end
    end
  end
end
