require 'spec_helper'

describe Teacher do
  it 'initializes with a name and an apparatus' do
    test_teacher = Teacher.new({'name' => 'Daniela', 'apparatus' => 'static trapeze'})
    expect(test_teacher).to be_an_instance_of Teacher
    expect(test_teacher.name).to eq 'Daniela'
    expect(test_teacher.apparatus).to eq 'static trapeze'
  end
end
