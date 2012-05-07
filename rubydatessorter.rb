require 'json'
require 'date'

class TimeSpentCalculator

  def initialize
    @no_dates = []
    @records_with_dates = []
    @total_days_recorded = 0
    @ready_to_dump = {}
  end

  def read_and_split_into_arrays
    file = File.open("../data/alldata.csv", "r")
    @headers = file.gets.chomp.split(',')

    file.each_line do |row|
 
      record = row.chomp.split(',') 
        if record.empty? 
            #a blank row. TODO how to do this using unless?
        else    
          start_date = record[7].tr_s('"', '').strip
          end_date = record[12].tr_s('"', '').strip
            if start_date.eql?"NULL" or end_date.eql?"NULL"
                #we could get some data here, like what project, what date it was, etc. 
                #But no need for now. 
                @no_dates << record
            else
                #get the project
                #calculate the time spent
                start_date_as_date = Date.parse(start_date)
                end_date_as_date = Date.parse(end_date)
                #ideally this would be week days, but not hugely important for this visualisation      
                time_spent_in_days = (end_date_as_date - start_date_as_date).to_i          
                #do we need this? 
                @total_days_recorded +=time_spent_in_days
                #what information do we want?
                #we could get T-shirt size here but a lot of records don't have them - could discuss...
                
                project = record[1].tr_s('"', '').strip

                feature = { "id" => record[0].tr_s('"', '').strip,
                            "name" => record[0].tr_s('"', '').strip, #why both?
                            "data" => {"project" => project,
                                       "$angularWidth" => time_spent_in_days,
                                       "description" => "would be good to have something here",
                                       "type" => record[2].tr_s('"', '').strip,
                                       "startDate" => start_date,
                                       "endDate" => end_date,
                                       "timeTaken" => time_spent_in_days,                                       
                                       "$color" => "#FCD9A1",   #ahem! also - maybe have this dependent on type?
                                       "size"  => time_spent_in_days #come back to why this is duplicated in the example
                                        },
                            "children" => []
                         }
                @records_with_dates << feature
            end
          
        end
    end
  end
  
  def split_features_by_project
    a = {"id" => "A",  
         "name" => "Project A",  
         "data" => {  
            "$angularWidth" => 0,
            "description" => "some stuff about project A",  
            "$color" => "#FCD9A1",   
            "size" => 0 
            },  
        "children" => []  
        }  
    c = {"id" => "C",  
         "name" => "Project C",  
         "data" => {  
            "$angularWidth" => 0,
            "description" => "some stuff about project C",  
            "$color" => "#FCD9A1",   
            "size" => 0 
            },  
        "children" => []  
        }  
    f = {"id" => "F",  
         "name" => "Project F",  
         "data" => {  
            "$angularWidth" => 0,
            "description" => "some stuff about project F",  
            "$color" => "#FCD9A1",   
            "size" => 0 
            },  
        "children" => []  
        }  
    p = {"id" => "P",  
         "name" => "Project P",  
         "data" => {  
            "$angularWidth" => 0,
            "description" => "some stuff about project P",  
            "$color" => "#FCD9A1",   
            "size" => 0 
            },  
        "children" => []  
        }  
    s = {"id" => "S",  
         "name" => "Project S",  
         "data" => {  
            "$angularWidth" => 0,
            "description" => "some stuff about project S",  
            "$color" => "#FCD9A1",   
            "size" => 0 
            },  
        "children" => []  
        }  

    @records_with_dates.each do |feature|
       data = feature["data"] 
       project = data["project"] 
      if "Project A".eql?project 
        a["data"]["$angularWidth"] += data["timeTaken"]
        a["data"]["size"] += data["timeTaken"] #TODO - avoid repetition     
        children = a["children"]
        children << feature        
     elsif "Project C".eql?project
        c["data"]["$angularWidth"] += data["timeTaken"]
        c["data"]["size"] += data["timeTaken"]      
        children = c["children"]
        children << feature        
     elsif "Project F".eql?project
        f["data"]["$angularWidth"] += data["timeTaken"]
        f["data"]["size"] += data["timeTaken"]      
        children = f["children"]
        children << feature        
     elsif "Project P".eql?project
        p["data"]["$angularWidth"] += data["timeTaken"]
        p["data"]["size"] += data["timeTaken"]       
        children = p["children"]
        children << feature        
     elsif "Project S".eql?project
        s["data"]["$angularWidth"] += data["timeTaken"]
        s["data"]["size"] += data["timeTaken"]      
        children = s["children"]
        children << feature        
      else
        puts "no project or #{feature.project}" 
      end
    end

#    puts "Project A no of features should be 204 and is: #{a["children"].length} and time taken should be 4186 and is = #{a["data"]["size"]}"
#    puts "Project C no of features should be 27 and is: #{c["children"].length} and time taken should be 1088 and is = #{c["data"]["size"]}"
#    puts "Project F no of features should be 8 and is: #{f["children"].length} and time taken should be 22 and is = #{f["data"]["size"]}"
#    puts "Project P no of features should be 8 and is: #{p["children"].length} and time taken should be 12 and is = #{p["data"]["size"]}"
#    puts "Project S no of features should be 122 and is: #{s["children"].length} and time taken should be 4084 = #{s["data"]["size"]}"
    @ready_to_dump["A"] = a
    @ready_to_dump["C"] = c
    @ready_to_dump["F"] = f
    @ready_to_dump["P"] = p
    @ready_to_dump["S"] = s

    #TODO this is not quite right. Shouldn't be A =, etc. Also, needs to be var json = or whatever. Nearly there!
    File.open('test.rb', 'w') do |f|  
        f.puts JSON.dump(@ready_to_dump)  
    end


  end

end
   
calculator = TimeSpentCalculator.new
calculator.read_and_split_into_arrays
calculator.split_features_by_project
