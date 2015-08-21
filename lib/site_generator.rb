require 'pry'
class SiteGenerator


  def between_ul
    Movie.all.map {|movie| "<li><a href=\"movies/#{movie.url}\">#{movie.title}</a></li>"}.join

  end


  def make_index!
    index = <<-HTML
    <!DOCTYPE html>
    <html>
      <head>
        <title>Movies</title>
      </head>
      <body>
        <ul>#{between_ul}</ul>
      </body>
    </html>
    HTML

    File.open('_site/index.html', 'w') {|f| f.puts index}
  end

  def generate_pages!
    Dir.mkdir "_site/movies" unless File.exists? "_site/movies"
    template = File.read('lib/templates/movie.html.erb')
      erb = ERB.new(template)
      Movie.all.each do |movie|
        x = erb.result(binding)

      File.open("_site/movies/#{movie.url}", "w") {|f| f.write(x)}
    end
  end

end
