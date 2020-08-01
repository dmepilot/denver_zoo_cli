class DenverZooCli::Cli
  
  def run 
    puts "\nWelcome to the Denver Zoo!\n"
    puts "Please select the animal you'd like to know more about:"
    DenverZooCli::Scraper.get_sites
    list_choices(DenverZooCli::Scraper.get_names)
    gets_choice
    facts_or_fun
  end
  
  def list_choices(names)
    names.each.with_index(1) do |value, index|
      puts "#{index}. #{value}"
    end
  end
  
  def gets_choice
    @choice=gets.strip.to_i-1
    name = DenverZooCli::Scraper.get_names[@choice]
    site = DenverZooCli::Scraper.get_sites[@choice]
    DenverZooCli::Scraper.get_animal_data(name, url)
    binding.pry
  end
  
  def facts_or_fun
    puts "Would like (1)scientific data or (2)fun facts?"
    x=gets.strip
      if x == "1"
        y=DenverZooCli::Scraper.get_sites[@choice]
        binding.pry
      elsif x == "2"
        y=DenverZooCli::Scraper.get_sites[@choice]
        binding.pry
    end
  end
  
end


