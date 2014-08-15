class Student < Ringmaster
  attr_reader :name, :id

  def initialize attributes
    @name = attributes['name']
  end

  def assign_to(teacher)
    DB.exec("INSERT INTO classes (teacher_id, student_id) VALUES (#{teacher.id}, #{@id})")
  end

end
