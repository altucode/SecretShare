class Hangman

  def initialize
    load_dictionary
  end

  def load_dictionary
    @dict = File.readlines("/Users/appacademy/Desktop/git_work/Hangman/dictionary.txt")
    @dict.each_with_index do |line, index|
      @dict[index] = line.chomp
    end
  end



end

new_game = Hangman.new
