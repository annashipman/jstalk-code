require 'json'
require 'csv'

class DataSorter

  Country = Struct.new(:id, :population)

  class Continent < Struct.new(:id, :description, :color, :country_color, :countries)
    def initialize(*args)
      super
      self.countries ||= []
    end
  end

  def initialize(csv_path)
    @csv_path = csv_path
  end

  def empty_continents
    [
      Continent.new("Africa", "A comment about Africa",
                    "#F5003D", "#00B8F5"),
      Continent.new("Asia", "A comment about Asia",
                    "#3366FF", "#FF0033"),
      Continent.new("Europe", "some stuff about Europe...",
                    "#F5003D", "#88C200"),
      Continent.new("North America", "some stuff about North America",
                    "#27C200", "#FFFF3D"),
      Continent.new("South America", "some stuff about South America",
                    "#FFFF00", "#BD7AFF"),
      Continent.new("Oceania", "A geopolitical region which includes the continent of Australia and the Pacific Islands",
                    "#9E3DFF", "#FF0033")
    ]
  end

  def continents_with_countries_from_csv
    empty_continents.tap { |continents|
      CSV.table(@csv_path).each do |row|
        continent = continents.find { |c| c.id == row[:continent] }
        continent.countries << Country.new(row[:country], row[:population])
      end
    }
  end

  def build_data_structure
    continents = continents_with_countries_from_csv
    {
      "id" => "World",
      "name" => "World",
      "data" => { "$type" => "none" },
      "children" => continents.map { |continent| {
        "id" => continent.id,
        "name" => continent.id,
        "data" => {
          "$angularWidth" => 0,
          "description" => continent.description,
          "$color" => continent.color,
          "population" => 0
        },
        "children" => continent.countries.map { |country| {
          "id" => country.id,
          "name" => country.id,
          "data" => {
            "$angularWidth" => country.population,
            "$color" => continent.country_color,
            "population" => country.population #try it with angular width
          },
          "children" => []
        }}
      }}
    }
  end
end

data_structure =  DataSorter.new("countries_by_continent.csv").build_data_structure
File.open("json.js", "w") do |io|
  io << "var json =" << JSON.dump(data_structure)
end
