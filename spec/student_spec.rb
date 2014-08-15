require 'spec_helper'

describe Student do
  it 'initializes with a name' do
    test_student = Student.new({'name' => 'Jordan'})
    expect(test_student).to be_an_instance_of Student
    expect(test_student.name).to eq 'Jordan'
  end

  it 'saves a student to the database' do
    test_student = Student.new({'name' => 'Jordan'})
    test_student.save
    expect(Student.all).to eq [test_student]
  end

  it 'is the same student if they have the same name' do
    test_teacher1 = Teacher.new({'name' => 'Jordan'})
    test_teacher2 = Teacher.new({'name' => 'Jordan'})
    expect(test_teacher1).to eq test_teacher2
  end

end
