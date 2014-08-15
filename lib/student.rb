class Student < Ringmaster
  attr_reader :name

  def initialize attributes
    @name = attributes['name']
  end
end
