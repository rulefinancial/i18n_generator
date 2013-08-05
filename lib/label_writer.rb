# encoding: utf-8

require_relative 'label'

class LabelWriter

  FILENAME_PREFIX = "labels_"

  FILE_HEADER_TEXT = <<-HEADER
# This resource bundle was generated using i18n_generator
  HEADER

  def initialize(output_directory)
    raise 'LabelWriter requires an output path' unless output_directory
    @output_path = output_directory
  end

  def prepare_output(labels, languages)
    output_files = Hash.new {|k,v| k[v] = [FILE_HEADER_TEXT]}

    labels.each do |label|
      languages.each do |language|
        output_files[language] << content_for_label(label, language)
      end
    end
    output_files
  end

	def write_labels(labels, languages)
    output_files = prepare_output(labels, languages)

    Dir.mkdir(@output_path) unless Dir.exists?(@output_path)

    output_files.keys.each do |language|
      output_filename = File.join(@output_path,label_filename(language))

      File.open(output_filename, 'w') do |file|
        file.write(output_files[language].join("\n"))
      end
    end
  end

  def content_for_label(label, language)
    content = []
    content << "\# #{label.description}" if label.description
    content << "#{label.id}=#{translation_for_label(label, language)}"
  end

  def translation_for_label(label, language)
    translation = label.send(language)
    "#{translation && !translation.empty? ? translation : label.en}"
  end

  def label_filename(language)
    FILENAME_PREFIX + language.to_s + ".properties"
  end
end