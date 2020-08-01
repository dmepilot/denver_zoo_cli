class DenverZooCli::Animal
  
  attr_accessor :url, :name, :klass, :order, :family, :genus, :species, :range, :habitat
  
  @@all = []
  
  def initialize(name, url)
    
  end
  
  def self.all
    @@all
  end
  
  
  
end