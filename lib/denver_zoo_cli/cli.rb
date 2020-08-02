class DenverZooCli::Cli

  def run 
      @again = "Y"
    while @again == "Y"
      puts "\nWelcome to the Denver Zoo!\n"
      puts "Please select the animal you'd like to know more about:"
      DenverZooCli::Scraper.get_sites
      list_choices(DenverZooCli::Scraper.get_names)
      gets_choice
      facts_or_fun
      again?
    end
  end
  
  def list_choices(names)
    names.each.with_index(1) do |value, index|
      puts "#{index}. #{value}"
    end
      puts "***************************"
      puts "Please enter choice number: "
  end
  
  def gets_choice
    @choice=gets.strip.to_i-1
    @name = DenverZooCli::Scraper.get_names[@choice]
    url = DenverZooCli::Scraper.get_sites[@choice]
    DenverZooCli::Scraper.get_animal_data(@name, url)
    
  end
  
  def facts_or_fun
    
   animal = DenverZooCli::Animal.all.find {|x| x.name == @name} 
    puts "#{animal.name}"
    puts "Would you like (1)scientific data or (2)fun facts?"
    x=gets.strip
      if x == "1"
        puts animal.name
        puts animal.klass
        puts animal.order
        puts animal.family
        puts animal.genus
        puts animal.species
        puts animal.range
        puts animal.habitat
        
      elsif x == "2"
        puts animal.fun_facts
    end
  end
  
  def valid?(input)
    input > 0 && input <= 70 
  
    #binding.pry
  end
    
  
  def again?
    puts "Would you like to chose another animal?"
    puts "'Y' to continue or any other key to exit:"
    @again = gets.strip.upcase
  end
  
end


