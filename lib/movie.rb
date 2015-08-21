require 'erb'
require 'pry'

class Movie

  @@movies = []

  attr_accessor :title, :release_date, :director, :summary

  def initialize(title, release_date, director, summary)
    @title = title
    @release_date = release_date
    @director = director
    @summary = summary

    @@movies << self

  end

  def url
    "#{title.downcase.gsub(" ","_")}.html"
  end

  def self.all
    @@movies
  end

  def self.reset_movies!
    @@movies.clear
  end

  def self.make_movies!
      movie_list = File.read('./spec/fixtures/movies.txt').split("\n")
      movie_list.each do |movie|
      movie = movie.split(" - ")
      Movie.new(movie[0], movie[1].to_i, movie[2], movie[3])
      end
    end

  def self.recent
      result = []
     @@movies.each {|movie| result << movie if movie.release_date >= 2012}
     result

  end

  def to_html
    template = File.read('lib/templates/movie.html.erb')
    ERB.new(template).result(binding)
  # binding.pry
  end


end
