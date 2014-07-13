class Hangman(word_guesser, word_chooser)

  def initialize
    load_dictionary
    play
  end

  def play
    pick_word
    render
    while !over?
      guess_letter
      check_letter
      render
    end
  end



  def load_dictionary
    @dict = File.readlines("/Users/appacademy/Desktop/git_work/Hangman/dictionary.txt")
    @dict.each_with_index do |line, index|
      @dict[index] = line.chomp
    end
  end

end



human = HumanPlayer.new
comp = ComputerPlayer.new
new_game = Hangman.new(human, comp)
