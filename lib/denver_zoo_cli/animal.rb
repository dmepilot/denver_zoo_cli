class DenverZooCli::Animal
  
  attr_accessor :name, :klass, :order, :family, :genus, :species
  
  @@all = []
  
  def initialize 
    @name = "https://denverzoo.org/animals/".each{|site| Nokogiri::HTML(open(site)).css("h1 span.fl-heading-text").text}
    
  end
  
  def self.all
    @@all
  end
  
  
  
end