class Student < Ringmaster
  attr_accessor :name, :id, :teachers

  def initialize attributes
    @name = attributes['name']
    @id = attributes['id'].to_i
    @teachers = []
  end

  def assign_to(teacher)
    DB.exec("INSERT INTO classes (teacher_id, student_id) VALUES (#{teacher.id}, #{@id});")
    teacher.instance_variable_set('@teacher_id', @id)
  end

  def teachers
    results = DB.exec("SELECT teachers.* FROM students
                      JOIN classes ON (students.id = classes.student_id)
                      JOIN teachers ON (classes.teacher_id = teachers.id)
                      WHERE students.id = #{@id};")
    results.each do |result|
      @teachers << Teacher.new(result)
    end
    @teachers
  end
end
