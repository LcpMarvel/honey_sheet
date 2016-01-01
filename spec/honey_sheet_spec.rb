require 'spec_helper'

describe HoneySheet do
  let(:name) { 'user' }
  let(:title_bar) { ['Name', 'Age', 'Birthday', 'Student', 'Favorite Food'] }

  let(:records) do
    tom_favorite_food = 'fruit: apple, banana; meat: beef, chicken'

    [
      ['John', 16, Date.new(2000, 1, 1), true,  'apple, bread'],
      ['Tom',  26, Date.new(1991, 1, 1), false, tom_favorite_food]
    ]
  end

  it 'has a version number' do
    expect(HoneySheet::VERSION).not_to be nil
  end

  describe 'export method' do
    context 'csv' do
      it 'calls CSV.package method' do
        expect(HoneySheet::CSV).to receive(:package).with(records, title_bar)

        HoneySheet.export(records, title_bar: title_bar, format: 'csv')
      end
    end

    context 'xls' do
      it 'calls Excel.package method' do
        expect(HoneySheet::Excel).to receive(:package).with(name, title_bar, records)

        HoneySheet.export(records, title_bar: title_bar, name: name, format: 'xls')
      end
    end
  end
end
