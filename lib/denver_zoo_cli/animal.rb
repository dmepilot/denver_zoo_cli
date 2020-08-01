class DenverZooCli::Animal
  
  attr_accessor :url, :name, :klass, :order, :family, :genus, :species, :range, :habitat
  
  @@all = []
  
  def initialize(name, url)
    @name = name
    @url = url
    self.save
  end
  
  def self.all
    @@all
  end
  
  def save
    @@all << self
  end
  
  
  
end