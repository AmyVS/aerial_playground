require 'pg'

require './lib/ringmaster'
require './lib/teacher'
require './lib/student'

DB = PG.connect(:dbname => 'aerial_playground')

def welcome
  puts "*" * 33
  puts "Welcome to the Aerial Playground!"
  puts "*" * 33
  puts "\n"
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
    puts "Invalid option. Please select [s], [t], or [x]."
  end
end

welcome
