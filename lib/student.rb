class Student < Ringmaster
  attr_reader :name, :id

  def initialize attributes
    @name = attributes['name']
  end

  def == another_student
    self.name == another_student.name
  end

end
