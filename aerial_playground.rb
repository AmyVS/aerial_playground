require 'pg'

require './lib/ringmaster'
require './lib/teacher'
require './lib/student'

DB = PG.connect(:dbname => 'aerial_playground')

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
  puts "\nPlease enter:"
  puts "[a] to add a teacher new teacher,"
  puts "[l] to list all teachers,"
  puts "[u] to update a teacher's apparatus,"
  puts "[r] to remove a teacher, or"
  puts "[x] to return to the main menu."

  user_choice = gets.chomp

  case user_choice
  when 'a'
    add_techer
  when 'l'
    list_teachers(:teacher)
  when 'u'
    update_apparatus
  when 'r'
    delete_teacher
  when 'x'
    puts "\nReturning to the main menu..."
    sleep(1)
    main_menu
  else
    puts "\nInvalid option. Please try again."
    sleep(1)
    teacher_menu
  end
end

def student_menu
  system('clear')
  puts "*" * 12
  puts "Student Menu"
  puts "*" * 12
  puts "\nPlease enter:"
  puts "[a] to a student to the database,"
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
    list_teachers(:student)
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
welcome
