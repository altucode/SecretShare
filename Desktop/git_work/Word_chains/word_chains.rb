class WordChainer
  require 'set'

  def initialize(dictionary_file_name)
    @dictionary = dictionary_file_name.to_set
  end

  def adjacent_words(word)
    adj_set = Set.new
    @dictionary.each do |dict_word|
      letter_wrong = 0
      dict_arr = dict_word.split("")
      dict_arr.each_index do |index|
        letter_wrong+=1 if dict_arr[index] != word[index]
      end
      adj_set.add(dict_word) if letter_wrong < 2 && dict_word.length == word.length
    end
    p adj_set
    end
  end







dict = File.readlines("/Users/appacademy/Desktop/git_work/Hangman/dictionary.txt").map {|word| word.chomp}
wordchain = WordChainer.new(dict)
wordchain.adjacent_words("duck")