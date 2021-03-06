require 'i18n_generator/excel_parser'
require 'i18n_generator/label'
require 'i18n_generator/label_writer'

module I18nGenerator
  class << self
    def process(source_spreadsheet, output_directory, bundle_prefix)
      excel_parser = I18nGenerator::ExcelParser.new(source_spreadsheet)
      label_writer = I18nGenerator::LabelWriter.new(output_directory, bundle_prefix)

      labels = excel_parser.parse
      label_writer.write_labels(labels, excel_parser.translation_languages)
    end
  end
end
