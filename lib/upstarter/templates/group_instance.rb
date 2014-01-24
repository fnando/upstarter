module Upstarter
  module Templates
    class GroupInstance < Base
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def export_to(dir)
        create_file file_name, render(:group_instance), dir
      end

      def file_name
        "#{options.name}-#{options.process_name}-#{options.process_number}.conf"
      end

      def additional_options
        {
          logfile: logfile,
          pidfile: pidfile
        }
      end

      def logfile
        "/var/log/#{base_name}.log"
      end

      def pidfile
        "/var/run/#{base_name}.pid"
      end

      def base_name
        "#{options.name}-#{options.process_name}/#{options.process_name}-#{options.process_number}"
      end
    end
  end
end
