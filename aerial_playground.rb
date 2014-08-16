require 'pg'
require 'pry'

require './lib/ringmaster'
require './lib/teacher'
require './lib/student'

DB = PG.connect(:dbname => 'aerial_playground')

@current_teacher = nil

def welcome
  system('clear')
  puts "*" * 33
  puts "Welcome to the Aerial Playground!"
  puts "*" * 33
  main_menu
end

def main_menu
  puts "\nPlease enter:"
  puts "[t] if you are a teacher,"
  puts "[s] if you are a student, or"
  puts "[x] to exit."
  user_choice = gets.chomp

  case user_choice
  when 't'
    teacher_menu
  when 's'
    student_menu
  when 'x'
    puts "\nHave a good one!"
    exit
  else
    puts "\nInvalid option. Please try again.\n\n"
    sleep(1)
    main_menu
  end
end

def teacher_menu
  system('clear')
  puts "*" * 12
  puts "Teacher Menu"
  puts "*" * 12

  puts "\nHere are the teachers currently in our database:"
  puts Teacher.show_list

  puts "\nTo update or remove a teacher's information,"
  puts "please select the index number of the teacher."
  puts "\nOtherwise, select:"
  puts "[a] to add a teacher new teacher, or"
  puts "[x] to return to the main menu."

  user_choice = gets.chomp

  if user_choice.to_i == 0
    case user_choice
    when 'a'
      add_teacher
    when 'x'
      puts "\nReturning to the main menu..."
      sleep(1)
      main_menu
    else
      puts "\nInvalid option. Please try again."
      sleep(1)
      teacher_menu
    end
  else
    @current_teacher = Teacher.all.fetch((user_choice.to_i)-1) do |number|
      puts "#{number+1} is not a valid option. Please try again.\n\n"
      sleep(1)
      teacher_menu
    end
    puts "\nPlease select from the following:"
    puts "[u] to update #{@current_teacher.name}'s apparatus,"
    puts "[r] to remove #{@current_teacher.name} from the database, or"
    puts "[x] to return to the teacher menu."

    user_choice = gets.chomp

    case user_choice
    when 'u'
      update_apparatus
    when 'r'
      remove_teacher
    when 'x'
      puts "Returning to the teacher menu..."
      sleep(1)
      teacher_menu
    else
      puts "Invalid option. Please try again."
      sleep(1)
      teacher_menu
    end
  end
end

def add_teacher
  puts "\n\nPlease enter the new teacher's name:"
  teacher_name = gets.chomp
  puts "\nPlease enter this teacher's apparatus:"
  teacher_apparatus = gets.chomp
  new_teacher = Teacher.new({'name' => teacher_name, 'apparatus' => teacher_apparatus})
  new_teacher.save
  puts "\n#{new_teacher.name} has been successfully added to the database."
  sleep(1)
  teacher_menu
end

def remove_teacher
  puts "\nAre you sure you want to remove #{@current_teacher.name} from the database? y/n"
  puts "Friendly reminder - this action cannot be undone."

  user_choice = gets.chomp

  case user_choice
  when 'y'
    binding.pry
    @current_teacher.delete
    puts "\n#{@current_teacher.name} has been successfully removed from the database."
    puts "Returning to the teacher menu..."
    sleep(1)
    teacher_menu
  when 'n'
    puts "Whew, that was a close one! Returning to the teacher menu..."
    sleep(1)
    teacher_menu
  else
    puts "Invalid option. Please try again."
    remove_teacher
  end
end


def student_menu
  system('clear')
  puts "*" * 12
  puts "Student Menu"
  puts "*" * 12
  puts "\nPlease enter:"
  puts "[a] to add a student to the database,"
  puts "[s] to list all students"
  puts "[t] to list all teachers and their apparatuses,"
  puts "[c] to change teachers,"
  puts "[r] to remove a student from the database"
  puts "[x] to return to the main menu."

  user_choice = gets.chomp

  case user_choice
  when 'a'
    add_student
  when 's'
    list_students
  when 't'
    teachers_by_apparatus
  when 'c'
    change_teachers
  when 'r'
    remove_student
  when 'x'
    puts "\nReturning to the main menu..."
    sleep(1)
    main_menu
  else
    puts "\nInvalid option. Please try again."
    sleep(1)
    student_menu
  end
end

def add_student
  puts "\n\nPlease enter the new student's name:"
  student_name = gets.chomp
  new_student = Student.new({'name' => student_name})
  new_student.save
  puts "\n#{new_student.name} has been successfully added to the database."
  sleep(1)
  student_menu
end

def list_teachers
  puts "\nHere's a list of all the teachers:"
  puts Teacher.show_list
  sleep(1)
  teacher_menu
end

welcome
