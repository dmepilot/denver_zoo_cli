class DenverZooCli::Cli
  
  @@all_names = []

  def run 
      @again = "Y"
    while @again == "Y"
      welcome_user
      DenverZooCli::Scraper.get_sites
      list_choices(DenverZooCli::Scraper.get_names)
      gets_choice
      fetch_data
      get_data_choice
      print_data
      again?
    end
  end
  
  def welcome_user 
    puts "\nWelcome to the Denver Zoo!\n"
    puts "Please select the animal you'd like to know more about:"
  end
  
  def list_choices(names)
    @@all_names = names
    names.each.with_index(1) do |value, index|
      puts "#{index}. #{value}"
    end
      puts "***************************"
      puts "Please enter choice number: "
  end
  
  def gets_choice
    @choice=gets.strip.to_i-1
    if @choice < 0 || @choice > @@all_names.size-1
      puts "Invalid. Please enter a number:"
      gets_choice
    end
    @choice
  end
  
  def fetch_data
    @name = DenverZooCli::Scraper.get_names[@choice]
    url = DenverZooCli::Scraper.get_sites[@choice]
    DenverZooCli::Scraper.get_animal_data(@name, url)
  end
  
  def get_data_choice
   @animal = DenverZooCli::Animal.all.find {|x| x.name == @name} 
    puts "*****#{@animal.name}*****"
    puts "Would you like (1)scientific data or (2)fun facts?"
    @data_choice=gets.strip
    if @data_choice == "1" || @data_choice == "2"
      @data_choice
    else
      get_data_choice
    end
  end
  
  def print_data
    if @data_choice == "1"
        puts ""
        puts "****#{@animal.name}*****"
        puts @animal.klass
        puts @animal.order
        puts @animal.family
        puts @animal.genus
        puts @animal.species
        puts @animal.subspecies if @animal.subspecies
        puts ""
        puts "*****Range*****"
        puts @animal.range
        puts ""
        puts "*****Habitat*****"
        puts @animal.habitat
        puts ""
        
      elsif @data_choice == "2"
        @animal.fun_facts.each do |fact|
           puts "\n**#{fact}**\n"
        end
      else
        get_data_choice
    end
  end
  
  def again?
    puts "\nWould you like to chose another animal?\n"
    puts "'Y' to continue or any other key to exit:"
    @again = gets.strip.upcase
  end
  
end


