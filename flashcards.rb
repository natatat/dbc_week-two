class Card
  attr_reader :definition, :term
  attr_accessor :solved
 
  def initialize(definition, term)
    @definition = definition
    @term = term
    @solved = false
  end
 
end
 
class FileManager
 
  def self.parse_text_file(file_name)
    @raw_data = File.open(file_name, 'r').readlines
    @raw_data.delete("\n")
    @parsed_data = @raw_data.each_slice(2).to_a
  end
 
  # def self.save_text_file!(new_file_name, data) # ? this is to make sure we dont overwrite old file
 
  # end
 
  # def self.fake_data
  #   @fake_data = ["To create a second name for the variable or method.\n", "alias\n", "\n", "\n", "\n", "A command that appends two or more objects together.\n", "and\n"]
  #   @fake_data.delete("\n")
  #   @fake_data = @fake_data.each_slice(2).to_a
  # end
 
end
 
class Deck
  attr_reader :object_data
 
  def initialize(data)
    @data = data
    @object_data = [] # this will be a duple
  end
  
  def fill_deck_with_card_objects
    @data.each do |card|
      @object_data << Card.new(card[0],card[1])
    end
  end
 
end
 
class DeckViewer
 
  def self.render_to_console(string)
    puts string
  end
 
end
 
class Application
 
  def self.run
    data = FileManager.parse_text_file('flashcard_samples.txt')
    deck = Deck.new(data)
    deck.fill_deck_with_card_objects
    
    DeckViewer.render_to_console("Welcome to MY DECK. To play, just enter the correct term for each definition. To quit, enter QUIT.")
    
 
    counter = 0
    correct_card_counter = 0
    until counter == deck.object_data.length
      DeckViewer.render_to_console("\nDefinition")
      DeckViewer.render_to_console(deck.object_data[counter].definition)
      input = gets
      case input
        when deck.object_data[counter].term
          deck.object_data[counter].solved = true
          deck.object_data.each {|card| correct_card_counter += 1 if card.solved == true}
          DeckViewer.render_to_console("VIP")
        when "QUIT\n"
          DeckViewer.render_to_console("\nYou got #{correct_card_counter}/#{deck.object_data.length} cards correct! You should probably study more.")
          exit
        else
          DeckViewer.render_to_console("Needs ID.")
      end
    counter += 1
    end
  
    DeckViewer.render_to_console("\nYou got #{correct_card_counter}/#{deck.object_data.length} cards correct! You should probably study more.")
 
    # EXTEND?:
    # iterate over entire array, if any are still false, ask em to play. 
    # would you like to play again? iterate over array, and only use ones they got wrong. cause they're dumb
 
  end
end
 
Application.run