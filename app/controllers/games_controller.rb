require 'open-uri'
require 'json'


class GamesController < ApplicationController
  def new
    grid_array = []
    # generate grid_size number of random letters and pass into array
    10.times do
      grid_array << ("A".."Z").to_a.sample
    end
    @letters = grid_array
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    url = "https://dictionary.lewagon.com/#{@word}"
    @dictionary = JSON.parse(URI.open(url).read)
    if @dictionary['found'] && word_in_grid
      @result = "<strong>Congratulations!</strong> #{@word.upcase} is a valid English word!".html_safe
    elsif @dictionary['found']
      @result = "Sorry but <strong>#{@word.upcase}</strong> cannot be made from #{@letters}".html_safe
    else
      @result = "Sorry but <strong>#{@word.upcase}</strong> is not a valid English word".html_safe
    end
  end

  private

  def word_in_grid
    # grid_array = generate_grid(6)
    word_array = @word.upcase.chars
    check = []
    word_array.each do |letter|
      check << @letters.include?(letter)
    end
    check.all?
  end
end
