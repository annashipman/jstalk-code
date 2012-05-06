require 'json'

class TimeSpentCalculator

#1. Reads in each line.
  def initialize
    
    @no_dates = []
    @puppies = []
    read
      puts "no dates total = #{@no_dates.length} and puppies total = #{@puppies.length}"
    
  end

  def read
    puts "No dates should be 0 and is #{@no_dates.length} and likewise puppies: #{@puppies.length}"    
    file = File.open("../../data/Alldata.csv", "r")

    file.each_line do |row|
 
      record = row.chomp.split(',') 
        if record.empty? #a blank row
            #do nothing
        else    
          project = record[1].tr_s('"', '').strip
          start_date = record[7].tr_s('"', '').strip
          end_date = record[12].tr_s('"', '').strip
            if start_date.eql?"NULL" or end_date.eql?"NULL"
                #put them in a no dates collection
                @no_dates << record
            else
                #these are the puppies we want to use!
                @puppies << record
            end
          
        end

    end
  end

   

  def headers
    @headers
  end



#2. Puts out the non-dates collection into a file for later examination.
#3. Sorts the dates collection into groups by Project and for now, outputs a basic tree, e.g.
#Project A
#    total time: 125 days.
#Project B
#    total time: 80 days.

end

m = TimeSpentCalculator.new

