class DenverZooCli::Cli
  
  def run 
    puts "Welcome to the Denver Zoo!"
    scrape_test
  
  end
  
  def scrape_test
    site = "https://denverzoo.org/animals/"
    scrape = Nokogiri::HTML(open(site))
    test = scrape.css("a.animals-list.ddd").attribute("href").value
    all_animal_sites = scrape.css("a.animals-list.ddd").collect {|x|  x.attribute("href").value}  #70 sites (elements 0-69)
    first_site = all_animal_sites[69]
    animal_classification = Nokogiri::HTML(open(first_site)).css("div.zoo-animal-classification").text
    rough_text = Nokogiri::HTML(open(first_site)).css("p").text
    x = Nokogiri::HTML(open(first_site)).css(".fl-module.fl-module-rich-text.fl-node-5b9808434ad12").css("div.fl-rich-text").css("p").text
    y = Nokogiri::HTML(open(first_site)).css(".fl-module").css("div.fl-rich-text").css("p")
    array = y.size
    animal_klass = y[1].text
    animal_order = y[2].text
    animal_family = y[3].text
    animal_genus = y[4].text
    animal_species = y[5].text
    binding.pry
  end
  
  
end

# <div class="fl-module-content fl-node-content">
# 		<div class="fl-rich-text">
# 	<p>African lions are typically found in savannas, plains, grasslands, dense bush and open woodlands where prey is abundant.&nbsp; They can also be found in smaller numbers in semidesert and mountain habitats.</p>
# <p>This species can be found in most countries of sub-Saharan Africa, primarily inhabiting eastern and southern Africa up to elevations of 13,700 ft. (4,200 m).</p>
# </div>
# 	</div>

