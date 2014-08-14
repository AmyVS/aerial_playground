require 'spec_helper'

describe Student do
  it 'initializes with a name' do
    test_student = Student.new({'name' => 'Jordan'})
    expect(test_student).to be_an_instance_of Student
    expect(test_student.name).to eq 'Jordan'
  end

end
