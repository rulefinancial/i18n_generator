# encoding: utf-8

require 'helper'

class LabelTest < Minitest::Test
	def setup
		@valid_label = I18nGenerator::Label.new({
			:id => "label.message.goodbye",
			:description => "A friendly goodbye",
			:en => "Goodbye",
			:fr => "Au revoir",
			:jp => "別れる時に発する語"
		})
	end

	def test_not_null
		refute_nil(@valid_label, "A valid label should be instantiated successfully")
	end

	def test_missing_id
		assert_raises(RuntimeError) do
			I18nGenerator::Label.new({
				:description => "A friendly goodbye",
				:en => "Goodbye",
				:fr => "Au revoir",
				:jp => "別れる時に発する語"
			})
		end
	end

  def test_blank_id
    assert_raises(RuntimeError) do
      I18nGenerator::Label.new({
        :id => "",
        :description => "A friendly goodbye",
        :en => "Goodbye",
        :fr => "Au revoir",
        :jp => "別れる時に発する語"
      })
    end
  end

	def test_missing_english_translation
		assert_raises(RuntimeError) do
			I18nGenerator::Label.new({
				:id => "label.message.goodbye",
				:description => "A friendly goodbye",
				:fr => "Au revoir",
				:jp => "別れる時に発する語"
			})
		end
	end

	def test_blank_english_translation
		assert_raises(RuntimeError) do
			I18nGenerator::Label.new({
				:id => "label.message.goodbye",
				:description => "A friendly goodbye",
        :en => "",
				:fr => "Au revoir",
				:jp => "別れる時に発する語"
			})
		end
	end

	def test_id_assignment
		assert_equal("label.message.goodbye", @valid_label.id)
	end

	def test_description_assignment
		assert_equal("A friendly goodbye", @valid_label.description)
	end

	def test_english_assignment
		assert_equal("Goodbye", @valid_label.en)
	end

	def test_jp_assignment
		assert_equal("別れる時に発する語", @valid_label.jp)
	end
end