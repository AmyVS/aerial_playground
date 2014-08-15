class Student < Ringmaster
  attr_reader :name, :id

  def initialize attributes
    @name = attributes['name']
  end

end
