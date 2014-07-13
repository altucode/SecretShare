class Hangman

  def initialize(word_guesser, word_chooser)
    @word_guesser = word_guesser
    @word_chooser = word_chooser
    @guessed_letters = []
    @wrong_guesses_left = 6
    play
  end

  def render
    p "You have #{@wrong_guesses_left} left"
    p @known_letters.join(" ")
  end

  def play

    @word_chooser.choose_word
    @known_letters = Array.new(@word_chooser.secret_word.length) {"_"}
    render

    while !over?
      guess = @word_guesser.guess_letter
      letter_locations = @word_chooser.check_letter(guess)
      fill_word(letter_locations,guess)
      render
    end
  end

  def over?
    if !@known_letters.include?("_")
      puts "You GOT IT!!!!!!!"
      return true
    elsif @wrong_guesses_left == 0
      puts "Yeah, ya blew it bro. The word was #{@word_chooser.secret_word}, duh"
      return true
    end
  end


  def fill_word(locations, letter)
    p locations
    if locations == []
      @wrong_guesses_left -= 1
      puts "Yikes..., no #{letter}'s."
    else
      puts "Yahtzee!! There's a #{letter} at these locations: #{locations}"
      locations.each do |fill_this_index|
        @known_letters[fill_this_index] = letter
    end
  end


end
end

class Player

end

class HumanPlayer < Player

  def guess_letter
    print "Guess a letter: "
    guess = gets.chomp.downcase
  end

end

class ComputerPlayer < Player

  attr_reader :secret_word

  def initialize
    @secret_word
  end

  def choose_word
    dict = File.readlines("/Users/appacademy/Desktop/git_work/Hangman/dictionary.txt")
    @secret_word = dict.sample.chomp
  end

  def check_letter(guessed_letter)
    letter_indexes = []
    if @secret_word.include?(guessed_letter)
      @secret_word.split("").each_with_index do |char, index|
        letter_indexes << index if char == guessed_letter
      end
    end
    letter_indexes
  end

end

human = HumanPlayer.new
comp = ComputerPlayer.new
new_game = Hangman.new(human, comp)
