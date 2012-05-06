require 'json'
require 'date'

class TimeSpentCalculator

  def initialize
    @no_dates = []
    @records_with_dates = []
    @total_days_recorded = 0
    read
  end

  def read
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
end
   
class Feature

  attr_accessor :project, :feature_id, :type, :start_date, :end_date, :time_taken

end
	
#3. Sorts the dates collection into groups by Project and for now, outputs a basic tree, e.g.
#Project A
#    total time: 125 days.
#Project B
#    total time: 80 days.


m = TimeSpentCalculator.new

