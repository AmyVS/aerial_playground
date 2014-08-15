class Teacher < Ringmaster
  attr_reader :name, :apparatus, :id

  def initialize attributes
    @name = attributes['name']
    @apparatus = attributes['apparatus']
  end

  def == another_teacher
    self.name == another_teacher.name &&
    self.apparatus == another_teacher.apparatus
  end
end
