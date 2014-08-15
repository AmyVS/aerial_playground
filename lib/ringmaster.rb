require 'rubygems'
require 'active_support/core_ext/string/inflections'

class Ringmaster

  def save
    if self.class == Teacher
      save = DB.exec("INSERT INTO teachers (name, apparatus) VALUES ('#{@name}', '#{@apparatus}') RETURNING id;")
      @id = save.first['id'].to_i
    elsif self.class == Student
      save = DB.exec("INSERT INTO students (name) VALUES ('#{@name}') RETURNING id;")
      @id = save.first['id'].to_i
    end
  end

  def self.all
    table_name = self.to_s.downcase.pluralize
    results = DB.exec("SELECT * FROM #{table_name};")
    class_instances = []
    results.each do |result|
      class_instances << self.new(result)
    end
    class_instances
  end

end
