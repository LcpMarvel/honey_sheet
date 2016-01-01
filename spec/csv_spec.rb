require 'spec_helper'

describe HoneySheet::CSV do
  let(:title_bar) { ['Name', 'Age', 'Birthday', 'Student', 'Favorite Food'] }

  let(:records) do
    tom_favorite_food = 'fruit: apple, banana; meat: beef, chicken'

    [
      ['John', 16, Date.new(2000, 1, 1), true,  'apple, bread'],
      ['Tom',  26, Date.new(1991, 1, 1), false, tom_favorite_food]
    ]
  end

  describe 'package method' do
    def package_csv
      HoneySheet::CSV.package(records, title_bar)
    end

    it 'returns an Enumerator' do
      expect(package_csv).to be_an_instance_of(Enumerator)
    end

    it 'can be collected to be a csv file' do
      expect_file = fixtures('users.csv')

      actual_file = ''
      package_csv.each { |element| actual_file << element }

      expect(actual_file.raw!).to eq expect_file.raw!
    end
  end
end
