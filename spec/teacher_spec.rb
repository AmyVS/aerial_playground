require 'spec_helper'

describe Teacher do
  it 'initializes with a name and an apparatus' do
    test_teacher = Teacher.new({'name' => 'Daniela', 'apparatus' => 'static trapeze'})
    expect(test_teacher).to be_an_instance_of Teacher
    expect(test_teacher.name).to eq 'Daniela'
    expect(test_teacher.apparatus).to eq 'static trapeze'
  end

  it 'saves a teacher to the database' do
    test_teacher = Teacher.new({'name' => 'Daniela', 'apparatus' => 'static trapeze'})
    test_teacher.save
    expect(Teacher.all).to eq [test_teacher]
  end

  it 'is the same teacher if they have the same name and apparatus' do
    test_teacher1 = Teacher.new({'name' => 'Daniela', 'apparatus' => 'static trapeze'})
    test_teacher2 = Teacher.new({'name' => 'Daniela', 'apparatus' => 'static trapeze'})
    expect(test_teacher1).to eq test_teacher2
  end

  it 'shows all teachers in the database' do
    test_teacher1 = Teacher.new({'name' => 'Daniela', 'apparatus' => 'static trapeze'})
    test_teacher2 = Teacher.new({'name' => 'Shersten', 'apparatus' => 'straps'})
    test_teacher1.save
    test_teacher2.save
    expect(Teacher.show_list).to eq ['1. Daniela', '2. Shersten']
  end

  it 'deletes a teacher from the database' do
    test_teacher = Teacher.new({'name' => 'Daniela', 'apparatus' => 'static trapeze'})
    test_teacher.save
    test_teacher.delete
    expect(Teacher.all).to eq []
  end

  it 'allows a teacher to update their apparatus' do
    test_teacher = Teacher.new({'name' => 'Daniela', 'apparatus' => 'static trapeze'})
    test_teacher.save
    new_apparatus = 'cloud swing'
    test_teacher.update_apparatus(new_apparatus)
    test_teacher.save
    expect(test_teacher.apparatus).to eq 'cloud swing'
  end

  it 'has many students' do
    test_teacher = Teacher.new({'name' => 'Daniela', 'apparatus' => 'static trapeze'})
    test_teacher.save
    test_student1 = Student.new({'name' => 'Jordan'})
    test_student1.save
    test_student2 = Student.new({'name' => 'Leia'})
    test_student2.save
    test_student1.assign_to(test_teacher)
    test_student2.assign_to(test_teacher)
    expect(test_teacher.students).to eq [test_student1, test_student2]
  end

  it 'unenrolls a student from a teacher' do
    test_student = Student.new({'name' => 'Lee'})
    test_student.save
    test_teacher = Teacher.new({'name' => 'Daniela', 'apparatus' => 'static trapeze'})
    test_teacher.save
    test_teacher.assign_to(test_student)
    test_teacher.unenroll(test_student)
    expect(test_teacher.students).to eq []
  end

  it 'removes teachers from classes if they are deleted from students table' do
    test_teacher = Teacher.new({'name' => 'Daniela', 'apparatus' => 'static trapeze'})
    test_teacher.save
    test_student = Student.new({'name' => 'Lee'})
    test_student.save
    test_teacher.assign_to(test_student)
    test_student.delete
    expect(test_student.teachers).to eq []
  end
end
