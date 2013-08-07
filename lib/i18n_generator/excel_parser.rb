# encoding: utf-8

require 'roo'
require 'i18n_generator/label'

module I18nGenerator
  ##
  # Responsible for parsing Excel spreadsheet to an array of Label objects
  # and inspecting a spreadsheet to return a list of included translations
  class ExcelParser

    FIRST_DATA_ROW_NUMBER = 2
    FIRST_TRANSLATION_COLUMN = 3

    LABEL_ID_COLUMN_INDEX = 1
    LABEL_DESCRIPTION_COLUMN_INDEX= 2

    def initialize(file_path)
      raise 'Invalid path supplied to ExcelParser' unless file_path
      
      begin
        @excel_data = excel_sheet_from_path(file_path)
      rescue Exception => e
        raise "Error while creating excel data: #{e}"
      end
    end

    ##
    # Returns the appropraite Roo Excel object from a
    # given path
    def excel_sheet_from_path(file_path)
      case File.extname(file_path)
        when '.xls'
          Roo::Excel.new(file_path)
        when '.xlsx'
          Roo::Excelx.new(file_path)
      end
    end

    ##
    # Parses the spreadsheet to a list of Labels
    def parse
      labels = [].tap do |labels_array|
        params_hash = {}

        FIRST_DATA_ROW_NUMBER.upto @excel_data.last_row do |row_num|        

          params_hash[:id] = @excel_data.cell(row_num, LABEL_ID_COLUMN_INDEX)
          params_hash[:description] = @excel_data.cell(row_num, LABEL_DESCRIPTION_COLUMN_INDEX)

          FIRST_TRANSLATION_COLUMN.upto @excel_data.last_column do |col_num|
            params_hash[@excel_data.cell(FIRST_DATA_ROW_NUMBER-1, col_num).to_sym] = @excel_data.cell(row_num, col_num)
          end

          labels_array << Label.new(params_hash)
        end
      end
    end

    ##
    # Returns an array of symbols representing the translation languages
    # contained in the Excel spreadsheet
    def translation_languages
      header_row = @excel_data.row(@excel_data.first_row)
      header_row[FIRST_TRANSLATION_COLUMN-1,header_row.size].map(&:to_sym)
    end

  end
end