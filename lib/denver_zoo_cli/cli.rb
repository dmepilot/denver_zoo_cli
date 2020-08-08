class DenverZooCli::Cli

  def run 
      @again = "Y"
    while @again == "Y"
      welcome_user
      DenverZooCli::Scraper.get_all_animals
      list_choices
      get_choice
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
  
  def list_choices
    @all_names = DenverZooCli::Animal.all.collect{|i| i.name}
    @all_names.each.with_index(1) do |value, index|
      puts "#{index}. #{value}"
    end
      puts "***************************"
      puts "Please enter choice number: "
  end
  
  def get_choice
    @choice=gets.strip.to_i-1
    if @choice < 0 || @choice > @all_names.size-1
      puts "Invalid. Please enter a number:"
      get_choice
    end
    @choice
  end
  
  def fetch_data
    @selected_animal = DenverZooCli::Animal.all[@choice]
    DenverZooCli::Scraper.get_animal_data(@selected_animal) 
  end
  
  def get_data_choice
    puts "*****#{@selected_animal.name}*****"
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
        puts "****#{@selected_animal.name}*****"
        puts @selected_animal.klass
        puts @selected_animal.order
        puts @selected_animal.family
        puts @selected_animal.genus
        puts @selected_animal.species
        puts @selected_animal.subspecies if @selected_animal.subspecies
        puts ""
        puts "*****Range*****"
        puts @selected_animal.range
        puts ""
        puts "*****Habitat*****"
        puts @selected_animal.habitat
        puts ""
        
      elsif @data_choice == "2"
        @selected_animal.fun_facts.each do |fact|
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


