module Fixture
  def fixtures(name)
    fixture_path = File.expand_path('../../fixtures', __FILE__)

    File.read("#{fixture_path}/#{name}")
  end
end
