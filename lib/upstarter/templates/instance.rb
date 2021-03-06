module Upstarter
  module Templates
    class Instance < Base
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def export_to(dir)
        create_file file_name, render(:instance), dir
      end

      def file_name
        "#{options.name}-#{options.process_name}.conf"
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

      def log_dir
        "/var/log/#{options.parent_name}-#{options.process_name}"
      end

      def run_dir
        "/var/run/#{options.parent_name}-#{options.process_name}"
      end

      def base_name
        "#{options.name}-#{options.process_name}/#{options.process_name}"
      end
    end
  end
end
