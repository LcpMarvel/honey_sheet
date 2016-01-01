require 'spec_helper'

describe HoneySheet::Excel do
  let(:title_bar) { ['Name', 'Age', 'Birthday', 'Student', 'Favorite Food'] }

  let(:records) do
    tom_favorite_food = {
      fruit: %w(apple banana),
      meat: %w(beef chicken)
    }

    [
      ['John', 16, Date.new(2000, 1, 1), true,  %w(apple bread)],
      ['Tom',  26, Date.new(1991, 1, 1), false, tom_favorite_food]
    ]
  end

  describe 'package method' do
    def package_xmls
      HoneySheet::Excel.package('users', title_bar, records)
    end

    it 'returns an Enumerator' do
      expect(package_xmls).to be_an_instance_of(Enumerator)
    end

    it 'can be collected to be a xml file' do
      expect_file = fixtures('users.xml')

      actual_file = ''
      package_xmls.each { |element| actual_file << element }

      expect(actual_file.raw!).to eq expect_file.raw!
    end
  end
end
