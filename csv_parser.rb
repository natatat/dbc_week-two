#week two

require 'csv'
 
class Person
  def initialize(row)
    @row = row
    @id = row[0]
    @first_name = row[1]
    @last_name = row[2]
    @email = row[3]
    @phone = row[4]
    @created_at = row[5]
  end
 
  def to_array
    @row
  end
end
 
class PersonParser
  attr_reader :file
  
  def initialize(file)
    @file = file
    @people = nil
  end
  
  def people
    # If we've already parsed the CSV file, don't parse it again.
    # Remember: @people is +nil+ by default.
    return @people if @people
 
    # parse the CSV file
    # and return an array of person objects here.  
    @people = []
    CSV.foreach(@file, :headers => true) do |row|
      @people << Person.new(row)
    end
    @people
  end
 
  def add_person(new_person)
    @people << new_person
  end
 
  def save
    CSV.open("people_new.csv", "w") do |csv|
      csv << ["id","first_name","last_name","email","phone","created_at"]
      @people.each do |person|
        csv << person.to_array
      end
    end
  end
 
end
 
parser = PersonParser.new('people.csv')
 
puts "There are #{parser.people.size} people in the file '#{parser.file}'."
 
parser.add_person Person.new(["201", "Uduwela", "Natalie", "natuduwela@gmail.com", "1-858-776-1370", Time.now])
 
puts "There are #{parser.people.size} people in the file '#{parser.file}'."
 
parser.save