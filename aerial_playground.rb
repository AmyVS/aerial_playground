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
  puts "\n"
  main_menu
end

def main_menu
  puts "Enter [t] if you are a teacher, [s] if you are a student, or [x] to exit."
  user_choice = gets.chomp

  case user_choice
  when 't'
    teacher_menu
  when 's'
    student_menu
  when 'x'
    puts "Have a good one!"
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
  puts "\nEnter [a] to add a teacher or student, [l] to list all teachers or students, [u] to update a teacher's apparatus,"
  puts "[r] to remove a teacher or student from the database, or [x] to return to the main menu."

  user_choice = gets.chomp

  case user_choice
  when 'a'
    add_person
  when 'l'
    list_people
  when 'u'
    update_apparatus
  when 'r'
    delete_person
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

welcome
