class DenverZooCli::Animal
  
  attr_accessor :url, :name, :klass, :order, :family, :genus, :species, :subspecies, :range, :habitat, :fun_facts
  
  @@all = []
  
  def initialize(name, url)
    @name = name
    @url = url
    @fun_facts = []
    self.save  
  end
  
  def self.all
    @@all
  end
  
  def save
      @@all << self 
  end

end