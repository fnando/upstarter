module Upstarter
  class Cli < Thor
    check_unknown_options!

    def self.exit_on_failure?
      true
    end

    default_task :help

    desc "export PROCESS_FILE [OUTPUT_DIR]", "Export Upstart configuration files"
    def export(process_file, output_dir = nil)
      process_file = File.expand_path(process_file)
      output_dir ||= File.join(File.dirname(process_file), "upstarter")
      output_dir = File.expand_path(output_dir)

      Exporter.new(process_file, output_dir).export!
    end

    desc "version", "Prints the Upstarter's version information"
    map %w(-v --version) => :version

    def version
      say "upstarter version #{VERSION}"
    end
  end
end
