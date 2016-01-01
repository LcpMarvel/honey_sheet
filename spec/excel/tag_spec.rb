require 'spec_helper'

describe HoneySheet::Excel::Tag do
  describe 'version tag' do
    it 'defines version of xls' do
      result = <<-XML.raw!
        <?xml version="1.0"?>
        <?mso-application progid="Excel.Sheet"?>
      XML

      expect(HoneySheet::Excel::Tag.version.raw!).to eq result
    end
  end

  describe 'header tag' do
    it 'defines header' do
      name = 'test'

      result = <<-XML.raw!
        <?xml version="1.0"?>
        <?mso-application progid="Excel.Sheet"?>
        <ss:Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
                  xmlns:o="urn:schemas-microsoft-com:office:office"
                  xmlns:x="urn:schemas-microsoft-com:office:excel"
                  xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
                  xmlns:html="http://www.w3.org/TR/REC-html40">
          <ss:Worksheet ss:Name="#{name}">
            <ss:Table>
      XML

      expect(HoneySheet::Excel::Tag.header(name).raw!).to eq result
    end
  end

  describe 'width tag' do
    it 'defines width of column' do
      result = <<-XML.raw!
        <ss:Column ss:Width="10"/>
        <ss:Column ss:Width="20"/>
        <ss:Column ss:Width="30"/>
      XML

      expected = HoneySheet::Excel::Tag.width_formatting([10, 20, 30], 3).raw!

      expect(expected).to eq result
    end
  end

  describe 'cell tag' do
    it 'defines a cell' do
      data = HoneySheet::Excel::Data.new('value', 'String')

      result = <<-XML.raw!
        <ss:Cell>
          <ss:Data ss:Type="#{data.type}">#{data.value}</ss:Data>
        </ss:Cell>
      XML

      expect(HoneySheet::Excel::Tag.cell(data).raw!).to eq result
    end
  end

  describe 'row tag' do
    context 'default records' do
      it 'defines a row' do
        records = ['text', 1, Date.new(2016, 1, 1), Time.new(2016, 1, 1, 0, 0, 0)]

        result = <<-XML.raw!
          <ss:Row>
            <ss:Cell><ss:Data ss:Type="String">text</ss:Data></ss:Cell>
            <ss:Cell><ss:Data ss:Type="Number">1</ss:Data></ss:Cell>
            <ss:Cell><ss:Data ss:Type="String">2016-01-01</ss:Data></ss:Cell>
            <ss:Cell><ss:Data ss:Type="String">2016-01-01 00:00:00</ss:Data></ss:Cell>
          </ss:Row>
        XML

        expect(HoneySheet::Excel::Tag.row(records).raw!).to eq result
      end
    end

    context 'records with special value' do
      it 'defines a row' do
        string_type = HoneySheet::Excel::DataTag::TYPES.fetch(:string)

        records = [
          'text',
          { value: 1,                             type: string_type },
          { value: Date.new(2016, 1, 1),          type: string_type },
          { value: Time.new(2016, 1, 1, 0, 0, 0), type: string_type }
        ]

        result = <<-XML.raw!
          <ss:Row>
            <ss:Cell><ss:Data ss:Type="String">text</ss:Data></ss:Cell>
            <ss:Cell><ss:Data ss:Type="String">1</ss:Data></ss:Cell>
            <ss:Cell><ss:Data ss:Type="String">2016-01-01</ss:Data></ss:Cell>
            <ss:Cell><ss:Data ss:Type="String">2016-01-0100:00:00+0800</ss:Data></ss:Cell>
          </ss:Row>
        XML

        expect(HoneySheet::Excel::Tag.row(records).raw!).to eq result
      end
    end
  end
end
