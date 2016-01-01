# https://msdn.microsoft.com/en-us/library/aa140066(v=office.10).aspx
module HoneySheet
  module Excel
    class Tag
      def self.version
        <<-XML
          <?xml version="1.0"?>
          <?mso-application progid="Excel.Sheet"?>
        XML
      end

      # Not support yet
      def self.styles
        ''.freeze
      end

      def self.header(name)
        <<-XML
          #{version}
          <ss:Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
                    xmlns:o="urn:schemas-microsoft-com:office:office"
                    xmlns:x="urn:schemas-microsoft-com:office:excel"
                    xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
                    xmlns:html="http://www.w3.org/TR/REC-html40">
            #{styles}
            <ss:Worksheet ss:Name="#{name}">
              <ss:Table>
        XML
      end

      def self.cell(data)
        <<-XML
          <ss:Cell>
            <ss:Data ss:Type="#{data.type}">#{data.value}</ss:Data>
          </ss:Cell>
        XML
      end

      def self.width(value)
        "<ss:Column ss:Width=\"#{value}\"/>"
      end

      def self.width_formatting(widths, column_size)
        xml = ''

        if widths.is_a?(Array)
          widths.each { |value| xml << width(value) }
        else
          column_size.times { |_value| xml << width(widths) }
        end

        xml
      end

      def self.row(records)
        str = '<ss:Row>'

        records.each do |record|
          data = HoneySheet::Excel::Parser.execute(record)

          str << cell(data)
        end

        str << '</ss:Row>'
        str
      end

      def self.footer
        <<-XML
              </ss:Table>
            </ss:Worksheet>
          </ss:Workbook>
        XML
      end
    end
  end
end
