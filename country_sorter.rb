require 'json'

class DataSorter

  def initialize
    @countries = []
  end

  def read_and_split_into_arrays
    file = File.open("../data/countries_by_continent.csv", "r")
    @headers = file.gets.chomp.split(',')

    file.each_line do |row|
 
      record = row.chomp.split(',') 
          continent = record[0]
          country_name = record[1]
          population = record[2]
          
          country = { "id" => country_name,
                                "name" => country_name, #why both?
                                "data" => {"continent" => continent,
                                           "$angularWidth" => population,
                                           "$color" => "",   #make this dependent on project
                                           "population"  => population #try it with angular width
                                            },
                                "children" => []
                     }
          
          @countries << country
     end
  end
  
  def split_countries_by_continent
   africa = {"id" => "Africa",  
         "name" => "Africa",  
         "data" => {  
            "$angularWidth" => 0,
            "description" => "A comment about Africa",  
            "$color" => "#F5003D",   
            "population" => 0 
            },  
        "children" => []  
        } 
    asia = {"id" => "Asia",  
         "name" => "Asia",  
         "data" => {  
            "$angularWidth" => 0,
            "description" => "A comment about Asia",  
            "$color" => "#3366FF",   
            "population" => 0 
            },  
        "children" => []  
        }  
    europe = {"id" => "Europe",  
         "name" => "Europe",  
         "data" => {  
            "$angularWidth" => 0,
            "description" => "some stuff about Europe...",  
            "$color" => "#F5003D",   
            "population" => 0 
            },  
        "children" => []  
        }  
    north_america = {"id" => "North America",  
         "name" => "North America",  
         "data" => {  
            "$angularWidth" => 0,
            "description" => "some stuff about North America",  
            "$color" => "#27C200",   
            "population" => 0 
            },  
        "children" => []  
        }  
    south_america = {"id" => "South America",  
         "name" => "South America",  
         "data" => {  
            "$angularWidth" => 0,
            "description" => "some stuff about South America",  
            "$color" => "#FFFF00",   
            "population" => 0 
            },  
        "children" => []  
        }  
    oceania = {"id" => "Oceania",  
         "name" => "Oceania",  
         "data" => {  
            "$angularWidth" => 0,
            "description" => "A geopolitical region which includes the continent of Australia and the Pacific Islands",  
            "$color" => "#9E3DFF",   
            "population" => 0 
            },  
        "children" => []  
        } 
      
    @countries.each do |country|
      continent = country["data"]["continent"] 
      if "Africa".eql?continent
        country["data"]["$color"]="#00B8F5"
        africa["children"] << country 
     elsif "Asia".eql?continent
        country["data"]["$color"]="#FF0033"
        asia["children"] << country 
     elsif "Europe".eql?continent
        country["data"]["$color"]="#88C200"
        europe["children"] << country 
     elsif "North America".eql?continent
        country["data"]["$color"]="#FFFF3D"
        north_america["children"] << country 
     elsif "South America".eql?continent
        country["data"]["$color"]="#BD7AFF"
        south_america["children"] << country 
     elsif "Oceania".eql?continent
        country["data"]["$color"]="#FF0033" #need another colour!
        oceania["children"] << country 
     end       

    parent = {"id" => "World",  
         "name" => "World",  
         "data" => {  
            "$type" => "none"
            },  
        "children" => [africa, asia, europe, north_america, south_america, oceania]  
        }

    File.open('json.js', 'w') do |file|
        file.puts "var json ="  
        file.puts JSON.dump(parent)  
    end

    end
  end
end
   
sorter = DataSorter.new
sorter.read_and_split_into_arrays
sorter.split_countries_by_continent
