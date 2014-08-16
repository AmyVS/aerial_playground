class Student < Ringmaster
  attr_reader :name, :id, :teachers

  def initialize attributes
    @name = attributes['name']
    @id = attributes['id'].to_i
    @teachers = []
  end

  def assign_to(teacher)
    DB.exec("INSERT INTO classes (teacher_id, student_id) VALUES (#{teacher.id}, #{@id});")
  end

  def teachers
    results = DB.exec("SELECT * FROM teachers JOIN classes
                      ON (teachers.id = classes.teacher_id)
                      WHERE (classes.student_id = #{@id});")
    results.each do |result|
      @teachers << Teacher.new(result)
    end
    @teachers
  end

end
