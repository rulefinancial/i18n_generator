# encoding: utf-8

require 'helper'

class ExcelParserTest < Minitest::Test
	def setup
		@excel_parser = I18nGenerator::ExcelParser.new(File.join(File.dirname(__FILE__), "..", "examples", "example_labels.xlsx"))
	end

	def test_not_null
		refute_nil(@excel_parser)
	end

	def test_translation_languages
		assert_equal(%w(en fr de ru jp gr).map(&:to_sym), @excel_parser.translation_languages,
					"Excel Parser should return the correct translation languages")
	end
end