# encoding: utf-8

require 'helper'

class LabelWriterTest < Minitest::Test
	def setup
		@label_writer = I18nGenerator::LabelWriter.new("output_path")
	end

	def test_not_null
		refute_nil(@label_writer)
	end

	def test_label_filename_generation
		assert_equal(@label_writer.label_filename("en"), "labels_en.properties")
	end

  def test_present_translation
    label = I18nGenerator::Label.new({
      :id => "label.message.goodbye",
      :description => "A friendly goodbye",
      :en => "Goodbye",
      :fr => "Au revoir",
      :jp => "別れる時に発する語"
    })

    assert_equal(@label_writer.translation_for_label(label, "jp"),
      "別れる時に発する語",
      "Translation should be returned correctly when language is present")
  end

  def test_english_used_when_translation_not_present
    label = I18nGenerator::Label.new({
      :id => "label.message.goodbye",
      :description => "A friendly goodbye",
      :en => "Goodbye",
      :fr => "",
      :jp => ""
    })

    assert_equal(@label_writer.translation_for_label(label, "fr"),
      "Goodbye",
      "English translation should be used when target language is not present")

    assert_equal(@label_writer.translation_for_label(label, "jp"),
      "Goodbye",
      "English translation should be used when target language is not present")
  end
end