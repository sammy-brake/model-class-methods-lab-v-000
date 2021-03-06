class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five 
    first(5)
    # where(id: [1,2,3,4,5])
  end 

  def self.dinghy 
    where("length < ?", 20)
  end 

  def self.ship 
    where("length > ?", 20)
  end 

  def self.last_three_alphabetically
    order('name DESC').first(3)
  end 

  def self.without_a_captain
    where(captain: nil)
  end 

  
    def self.with_three_classifications
      self.joins(:classifications).group("boats.id").having("COUNT(*)=3").select("boats.*")
    end
    

  

  def self.sailboats
     joins(:classifications).where("classifications.name = ?", 'Sailboat')
  end 

  def self.longest
    order(length: :desc).limit(1)
  end


end
