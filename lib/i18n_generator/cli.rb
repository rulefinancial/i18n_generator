require 'thor'

module I18nGenerator
  class CLI < Thor
    desc "process INPUT, OUTPUT_DIR", "convert INPUT xlsx to resource bundles in OUTPUT_DIR"
    def process(input_file, output_directory)
      I18nGenerator.process(input_file, output_directory)
    end
  end
end
