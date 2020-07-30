class DenverZooCli::Cli
  
  def run 
    puts "Welcome to the Denver Zoo!"
    scrape_test
  end
  
  def scrape_test
    site = "https://denverzoo.org/animals/"
    scrape = Nokogiri::HTML(open(site))
    test = scrape.css("a").text
    binding.pry
  end
  
end