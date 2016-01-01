require 'honey_sheet/excel/tag'

module HoneySheet
  module Excel
    class DataTag < Tag
      TYPES = {
        number:    'Number'.freeze,
        # date_time: 'DateTime'.freeze,
        # boolean:   'Boolean'.freeze,
        string:    'String'.freeze,
        error:     'Error'.freeze
      }

      def initialize(data)
        type = TYPES.fetch(data.type.to_sym, TYPES.fetch(:string))

        "<Data ss:Type=\"#{type}\">#{data.value}</Data>"
      end
    end
  end
end
