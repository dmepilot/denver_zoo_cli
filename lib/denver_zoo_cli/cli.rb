class DenverZooCli::Cli
  
  def run 
    puts "Welcome to the Denver Zoo!"
    scrape_test
  
  end
  
  def scrape_test
    site = "https://denverzoo.org/animals/"
    scrape = Nokogiri::HTML(open(site))
    test = scrape.css("a.animals-list.ddd").attribute("href").value
    all_animal_sites = scrape.css("a.animals-list.ddd").collect {|x|  x.attribute("href").value}
    first_site = all_animal_sites[0]
    animal_classification = Nokogiri::HTML(open(first_site)).css("div.zoo-animal-classification").text
    animal_habitat = Nokogiri::HTML(open(first_site)).css("div.fl-module-content fl-node-content").css("div.fl-rich-text").css("p").text
    binding.pry
  end
  
  
end

# <div class="fl-module-content fl-node-content">
# 		<div class="fl-rich-text">
# 	<p>African penguins, also called black-footed penguins, nest on sandy or rocky islands and mainland beaches with temperate climates, and they forage for food in cold ocean currents whose temperatures range from 42 to 68 degrees Fahrenheit (5-20° C).</p>
# <p>This species lives only on coastal islands and the mainland of southwestern Africa from Namibia to South Africa.</p>
# </div>
# 	</div>

