require 'honey_sheet/version'
require 'honey_sheet/excel'

require 'active_support/core_ext/string'
require 'active_support/core_ext/object/blank'

module HoneySheet
  def self.export(name, records, options = {})
    format = options.fetch(:format, 'xmls')

    case format
    when 'csv'

    when 'xmls'
      title_bar = options.fetch(:title_bar) do
        fail ArgumentError, 'The argument title_bar is not found'
      end

      Excel.package(name, title_bar, records, options)
    end
  end
end
