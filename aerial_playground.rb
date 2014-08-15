require './lib/teacher'
require './lib/student'

def welcome
  puts "*" * 32
  puts "Welcome to the Aerial Playground!"
  puts "*" * 32
  puts "\n"
  puts "Enter [t] if you are a teacher, [s] if you are a student, or [x] to exit."
  user_choice = gets.chomp

  case who
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
