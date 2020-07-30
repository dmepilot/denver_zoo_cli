class DenverZooCli::Cli
  
  def run 
    puts "Welcome to the Denver Zoo!"
    scrape_test
  end
  
  def scrape_test
    site = "https://denverzoo.org/animals/"
    scrape = Nokogiri::HTML(open(site))
    test = scrape.css("a.animals-list.ddd").first.attribute("href").value
    binding.pry
  end
  
end

# <div class="col-lg-4 col-md-6 m-b-30 m-b-10-sm">
#                     <a href="https://denverzoo.org/animals/african-lion/" class="animals-list ddd">
#                         <img class="img-fluid lazy loaded" src="https://denverzoo.org/wp-content/uploads/2018/09/south-african-lion_feature-350x350.jpg" data-src="https://denverzoo.org/wp-content/uploads/2018/09/south-african-lion_feature-350x350.jpg" alt="Animal" title="Animal" data-was-processed="true">
#                         <div class="animals-list__title">
#                             <h4> African Lion <span>Panthera leo melanochaita</span></h4>
#                         </div>
#                     </a>
#                 </div>