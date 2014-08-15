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
end
