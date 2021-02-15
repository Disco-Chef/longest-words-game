require 'open-uri'

class GamesController < ApplicationController
  VOWELS = ['A', 'E', 'I', 'O', 'U', 'Y']

  def new
    @letters = []
    5.times do
      @letters << VOWELS.sample
    end

    5.times do
      @letters << (('A'..'Z').to_a - VOWELS).sample
    end

    return @letters.shuffle!
  end

  def score
    @letters = params[:letters].split(' ')
    @user_word = params[:user_word]
    @included = made_from_array?(@user_word, @letters)
    @english = is_english_word?(@user_word)
  end

  # 1. The word can’t be built out of the original grid
  def made_from_array?(word, letters_array)
    word.chars.all? { |letter| word.count(letter) <= letters_array.count(letter)}
  end

  def is_english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    hash = JSON.parse(open(url).read)
    return hash['found'] # true/false
  end
  # 2. The word is valid according to the grid, but is not a valid English word
  # 3. The word is valid according to the grid and is an English word
end
