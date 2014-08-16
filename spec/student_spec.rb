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

  it 'deletes a student from the database' do
    test_student = Student.new({'name' => 'Jordan'})
    test_student.save
    test_student.delete
    expect(Student.all).to eq []
  end

  it 'has many teachers so they can learn a variety of apparatuses' do
    test_student = Student.new({'name' => 'Lee'})
    test_student.save
    test_teacher1 = Teacher.new({'name' => 'Daniela', 'apparatus' => 'static trapeze'})
    test_teacher1.save
    test_teacher2 = Teacher.new({'name' => 'Shersten', 'apparatus' => 'straps'})
    test_teacher2.save
    test_student.assign_to(test_teacher1)
    test_student.assign_to(test_teacher2)
    expect(test_student.teachers).to eq [test_teacher1, test_teacher2]
  end

  it 'unenrolls a student from a class' do
    test_student = Student.new({'name' => 'Lee'})
    test_student.save
    test_teacher = Teacher.new({'name' => 'Daniela', 'apparatus' => 'static trapeze'})
    test_teacher.save
    test_student.assign_to(test_teacher)
    test_student.unenroll(test_teacher)
    expect(test_student.teachers).to eq []
  end
end
