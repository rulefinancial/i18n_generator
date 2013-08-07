require 'i18n_generator/excel_parser'
require 'i18n_generator/label'
require 'i18n_generator/label_writer'

module I18nGenerator
	class << self
		def process(source_spreadsheet, output_directory)
      excel_parser = I18nGenerator::ExcelParser.new(ARGV[0])
      label_writer = I18nGenerator::LabelWriter.new(ARGV[1])

      labels = excel_parser.parse
      label_writer.write_labels(labels, excel_parser.translation_languages)
    end
	end
end