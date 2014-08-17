require 'pry'

class Teacher < Ringmaster
  attr_accessor :name, :apparatus, :id, :students

  def initialize attributes
    @name = attributes['name']
    @apparatus = attributes['apparatus']
    @id = attributes['id'].to_i
  end

  def self.show_teachers
    teachers = []
    self.all.each_with_index do |object, index|
      teachers << "#{index+1}. #{object.name} -- #{object.apparatus}"
    end
    teachers
  end

  def students
    results = DB.exec("SELECT students.* FROM teachers
                        JOIN classes ON (teachers.id = classes.teacher_id)
                        JOIN students ON (classes.student_id = students.id)
                        WHERE teachers.id = #{@id};")
    @students = []
    results.each do |result|
      @students << Student.new(result)
    end
    @students
  end

end
