module Upstarter
  module Templates
    class Base
      def template_dir
        @template_dir ||= Pathname.new(File.expand_path("../../../../templates", __FILE__))
      end

      def render(name)
        normalize_whitespace Erubis::Eruby.new(
          template_dir.join("#{name}.erb").read,
          trim: true
        ).result binding
      end

      def create_file(name, content, dir)
        FileUtils.mkdir_p(dir)

        File.open(File.join(dir, name), "w") do |file|
          file << content
        end
      end

      def additional_options
        {}
      end

      def interpolate(string)
        string.to_s % options.to_h.merge(additional_options)
      end

      def normalize_whitespace(text)
        text
          .gsub(/^  /, "")
          .gsub(/\n{2,}/, "\n\n")
      end
    end
  end
end
