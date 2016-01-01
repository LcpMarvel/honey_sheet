require 'honey_sheet/excel/tag'
require 'honey_sheet/excel/tag/data_tag'

require 'honey_sheet/excel/parser'
require 'honey_sheet/excel/recipe'

module HoneySheet
  module Excel
    TAG = HoneySheet::Excel::Tag

    def self.package(name, title_bar, enumerated_records)
      Enumerator.new do |row|
        row << TAG.header(name)

        row << TAG.row(title_bar)
        package_records(row, enumerated_records)

        row << TAG.footer
      end
    end

    def self.package_records(row, enumerated_records)
      return unless enumerated_records.respond_to?(:each)

      enumerated_records.each do |records|
        row << TAG.row(records)
      end
    end
  end
end
