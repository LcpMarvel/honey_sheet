require 'spec_helper'

describe HoneySheet::Excel::Parser do
  describe 'execute method' do
    it 'parse record to Data struct' do
      parser = HoneySheet::Excel::Parser
      data_tag = HoneySheet::Excel::DataTag
      result = HoneySheet::Excel::Data.new('2016-01-01', data_tag::TYPES.fetch(:string))

      expect(parser.execute(Date.new(2016, 1, 1))).to eq result

      expect(
        parser.execute(value: '2016-01-01', type: data_tag::TYPES.fetch(:string))
      ).to eq result
    end
  end
end
