require 'open-uri'
require 'json'


class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @letters = params[:letters].split(" ")
    @word = params[:word].upcase
    if @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) } && english_word?(@word) == true
      @result = "congrats"
    elsif @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) } && english_word?(@word) == false
      @result = "not english"
    else
      @result = 'not in the grid'
    end
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = open(url).read
    english = JSON.parse(word_serialized)
    english['found']
  end
end
