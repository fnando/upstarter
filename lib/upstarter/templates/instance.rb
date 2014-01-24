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
        if group?
          "#{options.name}-#{options.process_name}-#{options.process_number}.conf"
        else
          "#{options.name}-#{options.process_name}.conf"
        end
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
        if group?
          "#{options.name}/#{options.process_name}-#{options.process_number}"
        else
          "#{options.name}/#{options.process_name}"
        end
      end

      def group?
        options.instances > 1
      end
    end
  end
end
