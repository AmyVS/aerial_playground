class Teacher < Ringmaster
  attr_reader :name, :apparatus, :id

  def initialize attributes
    @name = attributes['name']
    @apparatus = attributes['apparatus']
  end

  # def save
  #   save = DB.exec("INSERT INTO teachers (name, apparatus) VALUES ('#{@name}', '#{@apparatus}') RETURNING id;")
  #   @id = save.first['id'].to_i
  # end

  def == another_teacher
    self.name == another_teacher.name &&
    self.apparatus == another_teacher.apparatus
  end

  def self.all
    results = DB.exec("SELECT * FROM teachers;")
    teachers = []
    results.each do |result|
      teachers << Teacher.new(result)
    end
    teachers
  end
end
