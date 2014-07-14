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
    adj_set.delete(word)
    end

    def run(source)
      @current_words = [source]
      @all_seen_words = [source]

      while !@current_words.empty?
        explore_current_words
      end
      @all_see_words
    end

    def explore_current_words

      @current_words.each do |word|

        new_current_words = []
        adjacent_words(word).each do |inner_word|

          if @all_seen_words.include?(inner_word)
            next
          else

            new_current_words << inner_word
            @all_seen_words << inner_word

          end

        end
        p @current_words = new_current_words
      end

    end

  end









dict = File.readlines("/Users/appacademy/Desktop/git_work/Hangman/dictionary.txt").map {|word| word.chomp}
wordchain = WordChainer.new(dict)
p wordchain.run("duck")