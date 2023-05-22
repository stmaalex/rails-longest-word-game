class GamesController < ApplicationController
  require "open-uri"

  def new
    @myarr = [*?a..?z]
    @result = @myarr.sample(10)
  end

  def score
    @user_word = params[:text]
    @result = params["result"].chars

    url = "https://wagon-dictionary.herokuapp.com/#{@user_word}"
    dictionary = URI.open(url).read
    api_response = JSON.parse(dictionary)["found"]

    if api_response == true
      @system_response = "#{params[:text]} is a real word, good job!"
      if @user_word.chars.all? { |letter| @result.include?(letter) }
        @system_response = "#{params[:text]} is a real word, you did well!"
      else
        @system_response += " #{params[:text]} word is valid, but can't be built out of the #{@result}"
      end
    else
      @system_response = "You can't build the word #{params[:text]} out of #{@result}"
    end
  end
end
