require 'pry'

class Teacher < Ringmaster
  attr_reader :name, :apparatus, :id, :students

  def initialize attributes
    @name = attributes['name']
    @apparatus = attributes['apparatus']
    @students = []
  end

  def update_apparatus(new_apparatus)
    results = DB.exec("UPDATE teachers SET apparatus = '#{new_apparatus}' WHERE id = #{@id} RETURNING apparatus;")
    @apparatus = results.first['apparatus']
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
