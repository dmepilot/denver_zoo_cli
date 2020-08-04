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
      classification = Nokogiri::HTML(open(url)).css("div.zoo-animal-classification").text.split("   ").reject! {|c| c == " " || c.empty? || c == "\n"}
      scientific_data = Nokogiri::HTML(open(url)).css(".fl-module-content.fl-node-content").css("div.fl-rich-text").css("p")
      #binding.pry
      new_animal.klass = classification.find{|c| c[/Class/]}.lstrip unless !classification.find{|c| c[/Class/]}
      new_animal.order =  classification.find{|c| c[/Order/]}.lstrip unless !classification.find{|c| c[/Order/]}
      new_animal.family = classification.find{|c| c[/Family/]}.lstrip unless !classification.find{|c| c[/Family/]}
      new_animal.genus = classification.find{|c| c[/Genus/]}.lstrip unless !classification.find{|c| c[/Genus/]}
      new_animal.species = classification.find{|c| c[/Species/]}.lstrip unless !classification.find{|c| c[/Species/]}
      new_animal.subspecies = classification.find{|c| c[/Subspecies/]}.lstrip unless !classification.find{|c| c[/Subspecies/]}
      #works for grizzly and cheetah but not most others
      if classification.find{|c| c[/Subspecies/]} || classification.find{|c| c[/Class/]} != classification[0] || classification.find{|c| c[/Class/]} != scientific_data[0]
        new_animal.habitat = Nokogiri::HTML(open(url)).css(".fl-rich-text").text.split("\t")[3].split("\n")[0]
        new_animal.range = Nokogiri::HTML(open(url)).css(".fl-rich-text").text.split("\t")[3].split("\n")[1]
      else
        new_animal.habitat = scientific_data[6].text
        new_animal.range = scientific_data[7].text
      end
      animal_fun_facts = Nokogiri::HTML(open(url)).css("div.fl-rich-text ul li")
      animal_fun_facts.each {|fact| new_animal.fun_facts << fact.text}
      new_animal.fun_facts.reject! {|f| f.empty?}
    end
  
end


