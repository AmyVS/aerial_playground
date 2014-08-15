class Teacher < Ringmaster
  attr_reader :name, :apparatus, :id

  def initialize attributes
    @name = attributes['name']
    @apparatus = attributes['apparatus']
  end

end
