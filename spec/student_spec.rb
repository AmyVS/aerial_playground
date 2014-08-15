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
    test_student1 = Student.new({'name' => 'Jordan'})
    test_student2 = Student.new({'name' => 'Jordan'})
    expect(test_student1).to eq test_student2
  end

  it 'shows all students in the database' do
    test_student1 = Student.new({'name' => 'Jordan'})
    test_student2 = Student.new({'name' => 'Audra'})
    test_student1.save
    test_student2.save
    expect(Student.show_list).to eq ['1. Jordan', '2. Audra']
  end

end
