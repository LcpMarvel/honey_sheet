require 'honey_sheet/version'
require 'honey_sheet/excel'
require 'honey_sheet/csv'

require 'active_support/core_ext/string'
require 'active_support/core_ext/object/blank'

module HoneySheet
  def self.export(records, options = {})
    format = options.fetch(:format, 'xls')

    case format
    when 'csv'
      CSV.package(records, options[:title_bar])
    when 'xls'
      title_bar = options.fetch(:title_bar) do
        fail ArgumentError, 'The argument title_bar is not found'
      end

      name = options.fetch(:name) do
        fail ArgumentError, 'The argument name is not found'
      end

      Excel.package(name, title_bar, records)
    end
  end
end
