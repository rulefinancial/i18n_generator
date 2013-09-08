require 'thor'

module I18nGenerator
  class CLI < Thor
    desc "process INPUT, OUTPUT_DIR", "convert INPUT xlsx to resource bundles in OUTPUT_DIR"
    method_option :prefix,
    							:default => "labels_",
    							:aliases => "-p",
    							:desc => "Specify the file prefix for generated bundle filenames (format <prefix><lang>.properties)"
    def process(input_file, output_directory)
      I18nGenerator.process(input_file, output_directory, options[:prefix])
    end
  end
end
