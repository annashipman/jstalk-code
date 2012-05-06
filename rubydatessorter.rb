require 'json'
require 'date'

class TimeSpentCalculator

  def initialize
    @no_dates = []
    @records_with_dates = []
    @total_days_recorded = 0
  end

  def read_and_split_into_arrays
    file = File.open("../data/Alldata.csv", "r")
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
                time_spent_in_days = (end_date_as_date - start_date_as_date).to_i #TODO actually, we want this to be week days               
                #add the time spent to the total
                @total_days_recorded +=time_spent_in_days
                #what information do we want?
                #we could get T-shirt size here but a lot of records don't have them - could discuss...
                feature = Feature.new
                feature.project = record[1].tr_s('"', '').strip
                feature.feature_id = record[0].tr_s('"', '').strip
                feature.type = record[2].tr_s('"', '').strip
                feature.start_date = start_date
                feature.end_date = end_date
                feature.time_taken = time_spent_in_days                              
                @records_with_dates << feature
            end
          
        end
    end
    puts "Total days recorded is #{@total_days_recorded} and number of features in our array is #{@records_with_dates.length}"
  end

  def split_features_by_project
    a = []
    a_total_time = 0
    c = []
    c_total_time = 0
    f = []
    f_total_time = 0
    p = []
    p_total_time = 0
    s = []
    s_total_time = 0
    @records_with_dates.each do |feature|
      if feature.project.eql?"Project A" 
        a_total_time += feature.time_taken        
        a << feature
      elsif feature.project.eql?"Project C"
        c_total_time += feature.time_taken 
        c << feature
      elsif feature.project.eql?"Project F"
        f_total_time += feature.time_taken         
        f << feature
      elsif feature.project.eql?"Project P"
        p_total_time += feature.time_taken 
        p << feature
      elsif feature.project.eql?"Project S" 
        s_total_time += feature.time_taken 
        s << feature
      else
        puts "no project or #{feature.project}" 
      end
    end
    #TODO actually we want this as a JSON tree for plugging into the diagram
    #In this form:
    #var json = {  
    #    "id": "aUniqueIdentifier",  
    #    "name": "usually a nodes name",  
    #    "data": {  
    #    "some key": "some value",  
    #    "some other key": "some other value"  
    #   },  
    #  "children": [ *other nodes or empty* ]  
    # };  
    
    #next step - make the form above the form required for the Sunburst
    puts "Project A no of features: #{a.length} and time taken = #{a_total_time}"
    puts "Project C no of features: #{c.length} and time taken = #{c_total_time}"
    puts "Project F no of features: #{f.length} and time taken = #{f_total_time}"
    puts "Project P no of features: #{p.length} and time taken = #{p_total_time}"
    puts "Project S no of features: #{s.length} and time taken = #{s_total_time}"

  end

end
   
class Feature

  attr_accessor :project, :feature_id, :type, :start_date, :end_date, :time_taken

end

calculator = TimeSpentCalculator.new
calculator.read_and_split_into_arrays
calculator.split_features_by_project
