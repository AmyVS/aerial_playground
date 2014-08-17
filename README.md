#Aerial Playground

This is a project I made using Ruby and PostgreSQL, and is intended to assist aerial teachers and students. There is a teacher -and- student menu in this program. Teachers can add to or remove themselves from the database, view what other apparatuses are being taught and by whom, see a list of their assigned students, and unenroll students from classes.

Students can add or remove themselves from the database, see what's being taught and by whom, sign-up for a specific teacher's class (and their apparatus), and unenroll themselves.

Thanks for checking out my project. Enjoy!

![image](http://amyvs.weebly.com/uploads/8/7/5/1/8751000/4469162.jpg?414)

---
##Installation
Look for the option on the right sidebar that says "HTTPS clone URL". Just click on the little clipboard icon to copy the address. Hop on over to your command line, type "git clone" and paste the copied address. That should give you a copy of all the files.

After you've cloned the files, you'll need to create a SQL database on your computer called "aerial_playground". Add three tables to it:

1. teachers: with id, name, and apparatus columns
2. students: with id, and name columns
3. classes: with id, student_id, and teacher_id columns

Once that's set, just hop on over to your aerial_playground directory and type "ruby aerial playground.rb" in your command line to run the program. Hope that helps!

---
**MIT License Copyright (c) 2014 Amy Vaillancourt-Sals**

---
