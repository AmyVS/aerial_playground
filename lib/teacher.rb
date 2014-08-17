require 'pry'

class Teacher < Ringmaster
  attr_accessor :name, :apparatus, :id, :students

  def initialize attributes
    @name = attributes['name']
    @apparatus = attributes['apparatus']
    @id = attributes['id'].to_i
    @students = []
  end

  def update_apparatus(new_apparatus)
    results = DB.exec("UPDATE teachers SET apparatus = '#{new_apparatus}' WHERE id = #{@id} RETURNING apparatus;")
    @apparatus = results.first['apparatus']
  end

  def assign_to(student)
    results = DB.exec("INSERT INTO classes (teacher_id, student_id) VALUES (#{@id}, #{student.id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def students
    results = DB.exec("SELECT * FROM students JOIN classes
                      ON (students.id = classes.student_id)
                      WHERE (classes.teacher_id = #{@id});")
    results.each do |result|
      @students << Student.new(result)
    end
    @students
  end

end
