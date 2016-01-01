require 'spec_helper'

describe HoneySheet::Excel::Recipe do
  describe 'transform method' do
    it 'transforms object to excel type' do
      excel_mod = HoneySheet::Excel

      {
        1                                       => [1, :number],
        1.0                                     => [1.0, :number],

        true                                    => [true, :string],

        nil                                     => [nil, :string],
        'string'                                => ['string', :string],
        %w(a b)                                 => ['a, b', :string],
        (1..2)                                  => ['1, 2', :string],
        { k1: 'v1', k2: 'v2' }                  => ['k1: v1; k2: v2', :string],
        Time.new(2016, 1, 1, 0, 0, 0)           => ['2016-01-01 00:00:00', :string],
        Date.new(2016, 01, 01)                  => ['2016-01-01', :string],
        DateTime.new(2016, 1, 1, 0, 0, 0, '+8') => ['2016-01-01 00:00:00', :string]
      }.each do |record, (value, type)|
        expect(
          excel_mod::Recipe.transform(record)
        ).to eq excel_mod::Data.new(value, excel_mod::DataTag::TYPES.fetch(type))
      end
    end
  end
end
