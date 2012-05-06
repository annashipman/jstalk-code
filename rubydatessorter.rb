require 'json'

class TimeSpentCalculator

  def initialize
    @no_dates = []
    @records_with_dates = []
    read
  end

  def read
    file = File.open("../data/Alldata.csv", "r")

    file.each_line do |row|
 
      record = row.chomp.split(',') 
        if record.empty? 
            #a blank row. TODO how to do this using unless?
        else    
          project = record[1].tr_s('"', '').strip
          start_date = record[7].tr_s('"', '').strip
          end_date = record[12].tr_s('"', '').strip
            if start_date.eql?"NULL" or end_date.eql?"NULL"
                @no_dates << record
            else
                @records_with_dates << record
            end
          
        end

    end
  end

   

#3. Sorts the dates collection into groups by Project and for now, outputs a basic tree, e.g.
#Project A
#    total time: 125 days.
#Project B
#    total time: 80 days.

end

m = TimeSpentCalculator.new

