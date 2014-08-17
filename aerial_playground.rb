require 'pg'
require 'pry'

require './lib/ringmaster'
require './lib/teacher'
require './lib/student'

DB = PG.connect(:dbname => 'aerial_playground')

@current_teacher = nil
@current_student = nil

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

  puts "\nplease select the index number of the teacher,"
  puts "to show assigned students or remove a teacher's information,"

  puts "\nOtherwise, select:"
  puts "[a] to add a new teacher, or"
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
    puts "[s] to see all of #{@current_teacher.name}'s students,"
    puts "[r] to remove #{@current_teacher.name} from the database, or"
    puts "[x] to return to the teacher menu."

    user_choice = gets.chomp

    case user_choice
    when 's'
      students_assigned_to_teacher
    when 'r'
      remove_teacher
    when 'x'
      puts "\nReturning to the teacher menu..."
      sleep(1)
      teacher_menu
    else
      puts "\nInvalid option. Please try again."
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

def students_assigned_to_teacher
  if @current_teacher.students.length == 0
    puts "\nLooks like #{@current_teacher.name} doesn't have any students yet."
    puts "Please go to the student menu to add new students to #{@current_teacher.name}'s class."
    sleep(1.5)
    main_menu
  else
    puts "\n\nHere's #{@current_teacher.name}'s current students:"
    @current_teacher.students.each_with_index do |student, index|
      puts "#{index+1}. #{student.name}"
    end
    puts "\nPlease enter the index number for the student, if you wish to unenroll them, or"
    puts "press any key to return to the teacher menu."
    user_input = gets.chomp

    if user_input.to_i == 0
      puts "\nReturning to the teacher menu..."
      sleep(1)
      teacher_menu
    else
      @current_student = @current_teacher.students.fetch((user_input.to_i)-1) do |number|
      puts "#{number+1} is not a valid option. Please try again."
      sleep(1)
      students_assigned_to_teacher
      end
      unenroll
    end
  end
end

def remove_teacher
  puts "\nAre you sure you want to remove #{@current_teacher.name} from the database? y/n"
  puts "Friendly reminder - this action cannot be undone."

  user_choice = gets.chomp

  case user_choice
  when 'y'
    @current_teacher.delete
    puts "\n#{@current_teacher.name} has been successfully removed from the database."
    puts "Returning to the teacher menu..."
    sleep(1)
    teacher_menu
  when 'n'
    puts "\nWhew, that was a close one! Returning to the teacher menu..."
    sleep(1)
    teacher_menu
  else
    puts "\nInvalid option. Please try again."
    remove_teacher
  end
end


def student_menu
  system('clear')
  puts "*" * 12
  puts "Student Menu"
  puts "*" * 12

  puts "Here are the students currently in our database:"
  puts Student.show_list

  puts "\nPlease select the index number of a student,"
  puts "to enroll a student in a class, unenroll a student,"
  puts "or remove a student from the database,"

  puts "\nOtherwise, select:"
  puts "[a] to add a new student, or"
  puts "[x] to return to the main menu."

  user_choice = gets.chomp

  if user_choice.to_i == 0
    case user_choice
    when 'a'
      add_student
    when 'x'
      puts "\nReturning to the main menu..."
      sleep(1)
      main_menu
    else
      puts "\nInvalid option. Please try again."
      sleep(1)
      student_menu
    end
  else
    @current_student = Student.all.fetch((user_choice.to_i)-1) do |number|
      puts "#{number+1} is not a valid option. Please try again."
      sleep(1)
      student_menu
    end
    puts "\nPlease select from the following:"
    puts "[e] to enroll #{@current_student.name} in a class,"
    puts "[s] to see which classes #{@current_student.name} is enrolled,"
    puts "[u] to unenroll #{@current_student.name} from a class,"
    puts "[r] to remove #{@current_student.name} from the database;"
    puts "[x] to return to the main menu."

    user_choice = gets.chomp

    case user_choice
    when 'e'
      enroll
    when 's'
      classes_enrolled
    when 'u'
      unenroll
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

def enroll
  puts "\nHere's a list of all the teachers and their apparatuses:"
  Teacher.all.each_with_index do |teacher, index|
    puts "#{index+1}. #{teacher.name} -- #{teacher.apparatus}"
  end
  puts "\nEnter an index number for a teacher, if you'd like to add #{@current_student.name} to their class,"
  puts "Otherwise, please enter [x] if you would like to return to the student menu."
  user_choice = gets.chomp

  if user_choice.to_i == 0
    case user_choice
    when 'x'
      puts "\nReturning to student menu..."
      sleep(1)
      student_menu
    else
      puts "\nInvalid option. Please try again."
      enroll
    end
  else
    @current_teacher = Teacher.all.fetch((user_choice.to_i)-1) do |number|
      puts "\n#{number+1} is not a valid option. Please try again.\n\n"
      sleep(1)
      enroll
    end
    choose_teacher
  end
end

def classes_enrolled
  if @current_student.teachers.length == 0
    puts "\nLooks like #{@current_student.name} has yet to enroll in a class."
    puts "Returning to student menu..."
    sleep(1.5)
    student_menu
  else
    puts "\n#{@current_student.name} is enrolled in these classes:"
    @current_student.teachers.each_with_index do |teacher, index|
      puts "#{index+1}. #{teacher.name} -- #{teacher.apparatus}"
    end
    puts "\nPress any key to return to the student menu."
    user_input = gets.chomp
    if user_input
      student_menu
    end
  end
end

def unenroll
  puts "\nAre you sure you want to unenroll #{@current_student.name} from #{@current_teacher.name}'s class? y/n"
  user_choice = gets.chomp

  case user_choice
  when 'y'
    @current_student.unenroll(@current_teacher)
    puts "\n#{@current_student.name} has been unenrolled from #{@current_teacher.name}'s class."
    sleep(1)
    main_menu
  when 'n'
    puts "\nNo worries, returning to main menu..."
    sleep(1)
    main_menu
  else
    puts "\nInvalid option. Please try again."
    unenroll
  end
end

def choose_teacher
  puts "\nYou've selected #{@current_teacher.name} and the apparatus, #{@current_teacher.apparatus}."
  puts "Would you like to add #{@current_student.name} to #{@current_teacher.name}'s class? y/n"

  user_choice = gets.chomp

  case user_choice
  when 'y'
    @current_student.assign_to(@current_teacher)
    puts "\n#{@current_student.name} has successfully signed up for #{@current_teacher.apparatus}."
    sleep(1)
    student_menu
  when 'n'
    puts "\nNo worries, returning to student menu..."
    sleep(1)
    student_menu
  else
    puts "\nInvalid option. Please try again."
    choose_teacher
  end
end

def remove_student
  puts "\nAre you sure you want to remove #{@current_student.name} from the database? y/n"
  puts "Friendly reminder - this action cannot be undone."

  user_choice = gets.chomp

  case user_choice
  when 'y'
    @current_student.delete
    puts "\n#{@current_student.name} has been successfully removed from the database."
    puts "Returning to the student menu..."
    sleep(1)
    student_menu
  when 'n'
    puts "\nWhew, that was a close one! Returning to the student menu..."
    sleep(1)
    student_menu
  else
    puts "\nInvalid option. Please try again."
    remove_student
  end
end

welcome
