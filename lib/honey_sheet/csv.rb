require 'csv'

module HoneySheet
  module CSV
    def self.package(records, title_bar = nil)
      Enumerator.new do |row|
        row << title_bar.to_csv if title_bar.present?

        records.each { |record| row << record.to_csv }
      end
    end
  end
end
