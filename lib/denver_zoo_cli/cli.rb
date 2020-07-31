class DenverZooCli::Cli
  
  attr_accessor :name
  
  def run 
    puts "Welcome to the Denver Zoo!"
    DenverZooCli::Scraper.get_sites
    DenverZooCli::Scraper.get_names
    #list_choices(all_animal_sites)
    
  end
  

  
 
  
  def list_choices(name)
    name.each.with_index(1) do |value, index|
      puts "#{index}. #{value}"
    end
  end
  
  
end


