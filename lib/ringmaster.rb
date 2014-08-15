require 'rubygems'
require 'active_support/core_ext/string/inflections'
require 'pry'

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

  def == another_instance
    if self.class == Teacher
      self.name == another_instance.name &&
      self.apparatus == another_instance.apparatus
    elsif self.class == Student
      self.name == another_instance.name
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

  def self.show_list
    list = []
    self.all.each_with_index do |object, index|
      list << "#{index+1}. #{object.name}"
    end
    list
  end

  def delete
    table_name = self.class.to_s.downcase.pluralize
    DB.exec("DELETE FROM #{table_name} WHERE id = #{self.id}")
  end

end
