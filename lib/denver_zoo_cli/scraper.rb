class DenverZooCli::Scraper
  
    @@all_animal_sites = []
    
    def self.get_sites
       @@all_animal_sites = Nokogiri::HTML(open("https://denverzoo.org/animals/")).css("a.animals-list.ddd").collect {|x|  x.attribute("href").value}
    end
    
    def self.get_names
        names=@@all_animal_sites.collect do |y|
          y.split("/")[4].gsub("-"," ").split(" ").each {|w| w.capitalize!}.join(" ")
        end
        names
    end
  
    def self.get_animal_data(name, url)
      new_animal=DenverZooCli::Animal.new(name, url)
      doc = url
      scientific_data=Nokogiri::HTML(open(url)).css(".fl-module").css("div.fl-rich-text").css("p")
      new_animal.klass = scientific_data[1].text
      new_animal.order = scientific_data[2].text
      new_animal.family = scientific_data[3].text
      new_animal.genus = scientific_data[4].text
      new_animal.species = scientific_data[5].text
      new_animal.habitat = scientific_data[6].text
      new_animal.range = scientific_data[7].text
      animal_fun_facts = Nokogiri::HTML(open(url)).css("div.fl-rich-text ul li")
      animal_fun_facts.each {|fact| new_animal.fun_facts << fact.text}
      new_animal.fun_facts.reject! {|f| f.empty?}
    end
  
end