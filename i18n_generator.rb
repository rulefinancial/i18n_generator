# encoding: utf-8
#!/usr/bin/env ruby

require_relative 'lib/label'
require_relative 'lib/excel_parser'
require_relative 'lib/label_writer'

unless ARGV.size == 2
  puts "Usage : label_generator.rb <input.xlsx> </path/to/output/dir>"
  exit
end

excel_parser = ExcelParser.new(ARGV[0])
label_writer = LabelWriter.new(ARGV[1])

labels = excel_parser.parse
label_writer.write_labels(labels, excel_parser.translation_languages)