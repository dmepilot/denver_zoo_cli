class DenverZooCli::Cli
  
  attr_accessor :all_animal_sites, :name
  
  def run 
    puts "Welcome to the Denver Zoo!"
    scrape_test
    #list_choices(all_animal_sites)
  end
  
  def initialize
    site = "https://denverzoo.org/animals/"
    scrape = Nokogiri::HTML(open(site))
    test = scrape.css("a.animals-list.ddd").attribute("href").value
    @all_animal_sites = scrape.css("a.animals-list.ddd").collect {|x|  x.attribute("href").value}  #70 animal sites (elements 0-69)
    
  end
  
  def scrape_test
    site = "https://denverzoo.org/animals/"
    scrape = Nokogiri::HTML(open(site))
    test = scrape.css("a.animals-list.ddd").attribute("href").value
    @all_animal_sites = scrape.css("a.animals-list.ddd").collect {|x|  x.attribute("href").value}  #70 animal sites (elements 0-69)
    first_site = all_animal_sites[0]
    animal_classification = Nokogiri::HTML(open(first_site)).css("div.zoo-animal-classification").text
    rough_text = Nokogiri::HTML(open(first_site)).css("p").text
    x = Nokogiri::HTML(open(first_site)).css(".fl-module.fl-module-rich-text.fl-node-5b9808434ad12").css("div.fl-rich-text").css("p").text
    y = Nokogiri::HTML(open(first_site)).css(".fl-module").css("div.fl-rich-text").css("p")
    z = Nokogiri::HTML(open(first_site)).css("div.fl-rich-text ul li")[0].text #adaptations
    w = Nokogiri::HTML(open(first_site)).css("div.fl-rich-text p").text
    array = y.size
    animal_klass = y[1].text
    animal_order = y[2].text
    animal_family = y[3].text
    animal_genus = y[4].text
    animal_species = y[5].text
    animal_range = y[6].text
    animal_habitat = y[7].text
    #animal_fun_facts = y[8].text
    name = Nokogiri::HTML(open(first_site)).css("h1 span.fl-heading-text").text
    
    binding.pry
  end
  
  def list_choices(name)
    name.each.with_index(1) do |value, index|
      puts "#{index}. #{value}"
    end
  end
  
  
end


