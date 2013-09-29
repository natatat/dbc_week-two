#week two

class NoOrangesError < StandardError
	puts "Salar is an idiot. He doesn't know how to p correctly."
end

class OrangeTree
	attr_reader :age, :height, :orange_sack

	def initialize
		@age = 0
		@height = 0
		@orange_sack = []
		puts "You planted a bigass orange tree"
	end

	def dead?
		@age < 10 ? "I AM ALIVE." : "I'm dead."
	end

	def add_oranges
		age.times do |x|
			orange_sack << Orange.new(rand(5..90))
		end
	end

# Ages the tree one year
def one_year_passes
	@age += 1
	@height += @age * 4
	orange_sack << add_oranges if @age < 10 && self.dead? == "I AM ALIVE"
end

# Returns +true+ if there are any oranges on the tree, +false+ otherwise
def any_oranges?
	@orange_sack.length > 0
end

def status
	puts "------------------"
	puts 'i have a big ass sack of oranges, CHECK EM OUTTTTT SON'
	puts orange_sack
	puts 'my tree is ' + height.to_s + ' MILES tall'
	puts "and it's hella old: " + age.to_s
	puts any_oranges?

	puts pick_an_orange!
	puts orange_sack
	puts '------------------'
end

# Returns an Orange if there are any
# Raises a NoOrangesError otherwise
def pick_an_orange!
	raise NoOrangesError, "This tree has no oranges" unless self.any_oranges?

# orange-picking logic goes here
@orange_sack.pop
end
end

class Orange
# Initializes a new Orange with diameter +diameter+
attr_reader :diameter, :index

def initialize(diameter)
	@diameter = diameter
	@@counter += 1
	@index = @@counter
end
@@counter = 0

def to_s
	'orange' + index.to_s + ' has a diameter of ' + diameter.to_s + ' meters'
end
#write method to increase diam as tree gets older

end

tree = OrangeTree.new
2.times do 
	tree.one_year_passes
	tree.add_oranges
	tree.status
end

puts tree.orange_sack[2]
puts tree.orange_sack
