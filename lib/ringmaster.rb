class Ringmaster

  # def save
  #   if self.class == Teacher
  #     save = DB.exec("INSERT INTO teachers (name, apparatus) VALUES ('#{@name}', '#{@apparatus}') RETURNING id;")
  #     @id = save.first['id'].to_i
  #   elsif self.class == Student
  #     save = DB.exec("INSERT INTO students (name) VALUES ('#{@name}') RETURNING id;")
  #     @id = save.first['id'].to_i
  #   end
  # end

end
