class Teacher
  attr_reader :name, :apparatus

  def initialize attributes
    @name = attributes['name']
    @apparatus = attributes['apparatus']
  end
end
