class DenverZooCli::Scraper
    
    def self.get_all_animals
       all_animal_sites = Nokogiri::HTML(open("https://denverzoo.org/animals/")).css("a.animals-list.ddd").collect {|x|  x.attribute("href").value}
       all_animal_sites.each do |y|
          DenverZooCli::Animal.new(y.split("/")[4].gsub("-"," ").split(" ").each {|w| w.capitalize!}.join(" "), y) unless DenverZooCli::Animal.all.find{|x| x.url == y}
        end
    end
  
    def self.get_animal_data(selected_animal)
      classification = Nokogiri::HTML(open(selected_animal.url)).css("div.zoo-animal-classification").text.split("   ").reject! {|c| c == " " || c.empty? || c == "\n"}
      scientific_data = Nokogiri::HTML(open(selected_animal.url)).css(".fl-rich-text")
      selected_animal.klass = classification.find{|c| c[/Class/]}.strip unless !classification.find{|c| c[/Class/]}
      selected_animal.order =  classification.find{|c| c[/Order/]}.strip unless !classification.find{|c| c[/Order/]}
      selected_animal.family = classification.find{|c| c[/Family/]}.strip unless !classification.find{|c| c[/Family/]}
      selected_animal.genus = classification.find{|c| c[/Genus/]}.strip unless !classification.find{|c| c[/Genus/]}
      selected_animal.species = classification.find{|c| c[/Species/]}.strip unless !classification.find{|c| c[/Species/]}
      selected_animal.subspecies = classification.find{|c| c[/Subspecies/]}.strip unless !classification.find{|c| c[/Subspecies/]}
      if scientific_data.text.split("\n")[5].strip.empty?
        selected_animal.range = scientific_data.text.split("\n")[8].strip
        selected_animal.habitat = scientific_data.text.split("\n")[7].strip
      else
        selected_animal.range = scientific_data.text.split("\n")[6].strip
        selected_animal.habitat = scientific_data.text.split("\n")[5].strip
      end
      animal_fun_facts = Nokogiri::HTML(open(selected_animal.url)).css("div.fl-rich-text ul li")
      animal_fun_facts.each {|fact| selected_animal.fun_facts << fact.text}
      selected_animal.fun_facts.reject! {|f| f.empty?}
    end
  
end


