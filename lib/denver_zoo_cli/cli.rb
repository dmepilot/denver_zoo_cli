class DenverZooCli::Cli
  
  attr_accessor :all_animal_sites, :name
  
  def run 
    puts "Welcome to the Denver Zoo!"
    #scrape_test
    #list_choices(all_animal_sites)
  end
  

  
 
  
  def list_choices(name)
    name.each.with_index(1) do |value, index|
      puts "#{index}. #{value}"
    end
  end
  
  
end


