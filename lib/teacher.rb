require 'pry'

class Teacher < Ringmaster
  attr_reader :name, :apparatus, :id

  def initialize attributes
    @name = attributes['name']
    @apparatus = attributes['apparatus']
  end

  def update_apparatus(new_apparatus)
    results = DB.exec("UPDATE teachers SET apparatus = '#{new_apparatus}' WHERE id = #{@id} RETURNING apparatus;")
    @apparatus = results.first['apparatus']
  end

end
