# encoding: utf-8

require 'i18n_generator/label'

module I18nGenerator
  ##
  # Responsible for processing a list of Labels for output
  # and writing them to output files
  class LabelWriter

    FILE_HEADER_TEXT = <<-HEADER
# THIS FILE IS GENERATED - PLEASE DO NOT EDIT (https://github.com/rulefinancial/i18n_generator)
    HEADER

    def initialize(output_directory, bundle_prefix)
      raise 'LabelWriter requires an output path' unless output_directory
      raise 'LabelWriter requires a filename prefix' unless bundle_prefix

      @output_path = output_directory
      @bundle_prefix = bundle_prefix
    end

    ##
    # Processes a list of Label with target languages
    # Returns a hash keyed by language, containing the
    # lines of the resource bundle to be written
    def prepare_output(labels, languages)
      output_files = Hash.new {|k,v| k[v] = [FILE_HEADER_TEXT]}

      labels.each do |label|
        languages.each do |language|
          output_files[language] << content_for_label(label, language)
        end
      end
      output_files
    end

    ##
    # Orchestrates the processing of Labels to be written
    # Writes files to output location
  	def write_labels(labels, languages)
      output_files = prepare_output(labels, languages)

      Dir.mkdir(@output_path) unless Dir.exists?(@output_path)

      output_files.keys.each_with_index do |language, idx|
        output_filename = File.join(@output_path,label_filename(language))

        File.open(output_filename, 'w') do |file|
          file.write(output_files[language].join("\n"))
          puts "[#{idx+1}/#{output_files.size}] Generated [#{label_filename(language)}]"
        end
      end
    end

    ##
    # Returns the content for a Label in a given language
    # Description is included if present
    def content_for_label(label, language)
      content = []
      content << "\# #{label.description}" if label.description
      content << "#{label.id}=#{translation_for_label(label, language)}"
    end

    ##
    # Returns the translation for a label in a given language
    # If the target language is not present, English will be used
    def translation_for_label(label, language)
      translation = label.send(language)
      "#{translation && !translation.empty? ? translation : label.en}"
    end

    ##
    # Produces the filename for a resource bundle
    def label_filename(language)
      @bundle_prefix + language.to_s + ".properties"
    end
  end
end